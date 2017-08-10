//
//  main.c
//  generateBMP
//
//  Created by Michael Hahn on 6/5/17.
//  Copyright © 2017 Michael Hahn. All rights reserved.
//
//  Enhanced by Dennis Li 08/01/2017
//  1. Store pixel matrix on heap instead of stack: from processing about 800 nodes to about 9.8k nodes 
//      for under a miniute, which is the largest provenance dataset we have at this time. (Created 
//      the alloc_matrix and free_matrix functions.)
//  2. Added a preprossessing stage of the input file to automatically determine the width and height of
//      the matrix being generated. (Efficency can possibly be impproved with given features of the input
//      file, such as the region where the max numbered node should occer in the file, i.e. towards the 
//      end.)
//  3. Parameterized the input file path and the output file path of this program, identified by -i and -o, 
//     respectively, on the command line. (Added the get_files function.)
//  
//  4. added -l option to specify the line number to highlight (horizontal line)
// 
//  5. added -h option to specify the line numbers to highlight by file (horizontal lines)
// 
//  6. added -v option to specify the line numbers to highlight by file (vertical lines)
//
//  Usage of this program: 
//  ./program_name -i input_file_path.txt -o output_file_path.bmp -l line_number_to_highlight -h path_to_highlight_file.txt -v path_to_highlight_file.txt
//  
//   options -i and -o are required; others are optional. 

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <inttypes.h>
#include <math.h>
#include <errno.h>
#include <unistd.h>
#include <ctype.h>

#define ARGLEN 100

unsigned int hash(char *str, int length);
uint64_t convert(const char *text);
void** alloc_matrix(size_t height, size_t width, size_t elem_size);
void free_matrix(void** matrix, size_t height);
void get_files(char** inputfile, char** outputfile, int argc, char* argv[], size_t filename_length, 
    int* opt_l, size_t* line_num, char** line_highlight_file_h, char** line_highlight_file_v);
int check_highlight_bound(size_t height, int opt_l, size_t line_num);
void* alloc_array(size_t len, size_t elem_size);
void free_array(void* array);
char* parse_highlights(FILE* highlight_fstream, size_t height);

int main(int argc, const char * argv[]) {
    char* inputfile;
    FILE * input;
    size_t width = 0;
    size_t height = 0;
    size_t max_node = 0;
    size_t from, to;
    char line[100];
    char array[24];
    char * token;
    char * colortoken;
    uint64_t fromlabel, tolabel, edgelabel;

    char* outputfile;
    FILE * output;
    unsigned int bitmapfileheader[3]; //combined bfReserved1 and bfReserved2
    unsigned int bitmapinfoheader[9]; //no biPlanes or biBitCount as they are shorts not ints
    int extrapaddingperline; //number of bytes that are just paddings for each horizontal line so that are multiples of 4
    int totalsize; //total size in bytes of this bmp file
    int x, y, n;
    unsigned int mixed;
    int red, green, blue;

    //options
    int opt_l = 0;// option for highlighting a single line; 0: false, 1: true
    size_t line_num = 0;

    char* line_highlight_file_h = NULL;
    FILE* highlight_fstream_h;
    char* highlights_h = NULL;

    char* line_highlight_file_v = NULL;
    FILE* highlight_fstream_v;
    char* highlights_v = NULL;


    //getting input and output file names from command line
    get_files(&inputfile, &outputfile, argc, (char**) argv, ARGLEN, &opt_l, &line_num, &line_highlight_file_h,
        &line_highlight_file_v);

    // * produce matrix of pixel data from edgelist
    //open the file to read edge list
    input = fopen(inputfile, "r");
    if (input == NULL) {
        perror("Error opening input file\n");
        exit(1);
    }
    while (fgets(line, 100, input) != NULL) {
        token = strtok(line, "\t");
        from = atoi(token);
        token = strtok(NULL, "\t");
        to = atoi(token); 

        if(from > max_node){
            max_node = from;
        }
        if(to > max_node){ 
            max_node = to;
        }
    }
    width = max_node + 1; 
    height = width;

    // bound checking for highlighting line 
    if(check_highlight_bound(height, opt_l, line_num) == -1){
        perror("higlight specified is out of bound\n");
        return -1; 
    }

    //parse line_highlight_file if exists
    if(line_highlight_file_h != NULL){
        highlight_fstream_h = fopen(line_highlight_file_h, "r");
        if(highlight_fstream_h == NULL){
            perror("Error opening line highlighting file\n");
            exit(1);
        }
        highlights_h = parse_highlights(highlight_fstream_h, height);
        // printf("%d\n", highlights_h[0]);
        // printf("%d\n", highlights_h[150]);
        // printf("%d\n", highlights_h[149]);
        // printf("%d\n", highlights_h[160]);
    }

    if(line_highlight_file_v != NULL){
        highlight_fstream_v = fopen(line_highlight_file_v, "r");
        if(highlight_fstream_v == NULL){
            perror("Error opening line highlighting file\n");
            exit(1);
        }
        highlights_v = parse_highlights(highlight_fstream_v, width);
    }


    // printf("width == height == %d\n", (int)width);
    
    // uint64_t frompixels[width][height];
    // uint64_t topixels[width][height];   
    // uint64_t edgepixels[width][height];
    int64_t** frompixels = (int64_t**)alloc_matrix(height, width, sizeof(uint64_t));
    int64_t** topixels = (int64_t**)alloc_matrix(height, width, sizeof(uint64_t));
    int64_t** edgepixels = (int64_t**)alloc_matrix(height, width, sizeof(uint64_t));
    if(!frompixels | !topixels | !edgepixels){
        perror("can't malloc\n"); 
        exit(1);
    }



    //initialize all pixels to -1
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            frompixels[y][x] = -1;
            topixels[y][x] = -1;
            edgepixels[y][x] = 0;
        }
    }

    
    fseek(input, 0, SEEK_SET);
    //read the edgelist one line at a time
    // int count = 0;
    while (fgets(line, 100, input) != NULL) {
        token = strtok(line, "\t");
        from = atoi(token);
        token = strtok(NULL, "\t");
        to = atoi(token);
        token = strtok(NULL, "\t");
        colortoken = strtok(token, ":");
        fromlabel = convert(colortoken);
        colortoken = strtok(NULL, ":");
        tolabel = convert(colortoken);
        colortoken = strtok(NULL, ":");
        edgelabel = convert(colortoken);
        
        //edge labels ORed to include all three labels and possibly multiple edge labels at the same same location in matrix
        frompixels[from][to] = fromlabel;
        topixels[from][to] = tolabel;
        edgepixels[from][to] = edgepixels[from][to] | edgelabel;
        // printf("%" PRIu64 "\n", frompixels[from][to]);
        // count++;
        
    }
    // printf("count is %d\n", count);
    fclose(input);
    


    // * produce dmp file
    //determine the extra padding size per line
    extrapaddingperline = 4 - ((width * 3) % 4);
    if (extrapaddingperline == 4) extrapaddingperline = 0;
    
    //determine total size of the graph, excluding header size
    totalsize = ((width * 3) + extrapaddingperline) * height;
    
    //bitmap file header
    //First two bytes are `B` and `M`
    bitmapfileheader[0] = totalsize + 54; //bfSize (header + contents)
    bitmapfileheader[1] = 0; //bfReserved1 + bfReserved2
    bitmapfileheader[2] = 54; //bfOffBits
    
    //bitmap info header
    bitmapinfoheader[0] = 40; //biSize
    bitmapinfoheader[1] = width; //biwidth
    bitmapinfoheader[2] = width; //biheight
    //Skip biPlanes and biBitCount since they are shorts
    bitmapinfoheader[3] = 0; //biCompression
    bitmapinfoheader[4] = totalsize; //biSizeImage; it is okay to set it to 0 if no compression
    bitmapinfoheader[5] = 0; //biXPelsPerMeter
    bitmapinfoheader[6] = 0; //biYPelsPerMeter
    bitmapinfoheader[7] = 0; //biClrUsed
    bitmapinfoheader[8] = 0; //biClrImportant
    
    //open the file and start writing to the file
    output = fopen(outputfile, "wb");
    if (output == NULL) {
        perror("Error opening ouput file\n"); 
        exit(1);
    }


    //write bitmap file header to the file
    fprintf(output, "BM");
    for (n = 0; n < 3; n++) {
        // printf("n=%d\n", n);
        fprintf(output, "%c", bitmapfileheader[n] & 0x000000FF);
        fprintf(output, "%c", (bitmapfileheader[n] & 0x0000FF00) >> 8);
        fprintf(output, "%c", (bitmapfileheader[n] & 0x00FF0000) >> 16);
        fprintf(output, "%c", (bitmapfileheader[n] & (unsigned int) 0xFF000000) >> 24);
    }
    

    //write bitmap info header to the file
    for (n = 0; n < 3; n++) {
        fprintf(output, "%c", bitmapinfoheader[n] & 0x000000FF);
        fprintf(output, "%c", (bitmapinfoheader[n] & 0x0000FF00) >> 8);
        fprintf(output, "%c", (bitmapinfoheader[n] & 0x00FF0000) >> 16);
        fprintf(output, "%c", (bitmapinfoheader[n] & (unsigned int) 0xFF000000) >> 24);
    }


    //biPlanes and biBitCount fields.
    fprintf(output, "%c", 1); //must be set to 1
    fprintf(output, "%c", 0);
    fprintf(output, "%c", 24); //24 bits per pixel, a total of 16.7 million colors
    fprintf(output, "%c", 0);
    

    for (n = 3; n < 9; n++) {
        fprintf(output, "%c", bitmapinfoheader[n] & 0x000000FF);
        fprintf(output, "%c", (bitmapinfoheader[n] & 0x0000FF00) >> 8);
        fprintf(output, "%c", (bitmapinfoheader[n] & 0x00FF0000) >> 16);
        fprintf(output, "%c", (bitmapinfoheader[n] & (unsigned int) 0xFF000000) >> 24);
    }

    //headers are done. Write data now
    for (y = height - 1; y >= 0; y--) { //BMP images are proceeded from the bottom to the top
        for (x = 0; x < width; x++) {
            //fprintf(stdout, "%llu\n", frompixels[x][y]);

            // no edge from x to y
            if(frompixels[x][y] == -1 && topixels[x][y] == -1){
                //highlight line with white if (x, y) is on the line
                if((opt_l && y == line_num) || (highlights_h && highlights_h[y] == 1)){
                    red = 255;
                    green = 255; 
                    blue = 255;
                }
                else if(highlights_v && highlights_v[x] == 1){
                    red = 255;
                    green = 255; 
                    blue = 255;
                }
                //mark pixel as black
                else{ 
                    red = 0; 
                    green = 0; 
                    blue = 0;
                }
            }
            else{
                memcpy(&array[0], &frompixels[x][y], sizeof(uint64_t));
                memcpy(&array[sizeof(uint64_t)], &topixels[x][y], sizeof(uint64_t));
                memcpy(&array[2 * sizeof(uint64_t)], &edgepixels[x][y], sizeof(uint64_t));
                //fprintf(stdout, "%llu\n", *((uint64_t*)&array[0]));
                mixed = hash(array, 24);
            
                red = mixed & 0x000000FF;
                if (red > 255) red = 255;
                green = (mixed & 0x00FF0000) >> 16;
                if (green > 255) green = 255;
                blue = (mixed & 0x0000FF00) >> 8;
                if (blue > 255) blue = 255;
            }


           
//            if (mixed != 0) {
//                fprintf(stdout, "%u ", mixed);
//                fprintf(stdout, "%u ", red);
//                fprintf(stdout, "%u ", green);
//                fprintf(stdout, "%u\n", blue);
//            }
            
            //it is written in BGR format
            fprintf(output, "%c", blue);
            fprintf(output, "%c", green);
            fprintf(output, "%c", red);
            
        }
        if (extrapaddingperline) { //paddings at the end of each horizontal line
            for (n = 0; n < extrapaddingperline; n++) {
                fprintf(output, "%c", 0);
            }
        }
    }
    
    //close the file when done
    fclose(output);
    free_matrix((void**)frompixels, height);
    free_matrix((void**)topixels, height);
    free_matrix((void**)edgepixels, height);
    if(highlights_h){ 
        free_array(highlights_h);
    }
    if(highlights_v){ 
        free_array(highlights_v);
    }
    
    return 0;
}


unsigned int hash(char *str, int length)
{
    unsigned int hash = 5381;
    
    while (length--)
        hash = ((hash << 5) + hash) + *str++; /* hash * 33 + c */
    
    return hash;
}


uint64_t convert(const char *text)
{
    uint64_t number=0;
    
    for(; *text; text++)
    {
        char digit=*text-'0';
        number=(number*10)+digit;
    }
   return number;
}

//allocate heap mem for an array of length len and each elem has size elem_size
void* alloc_array(size_t len, size_t elem_size){
    return calloc(len, elem_size);
}


void free_array(void* array){
    free(array);
}

// allocate heap memory for a 2-D matrix with height height, width width, 
// and each element has size elem_size. 
void** alloc_matrix(size_t height, size_t width, size_t elem_size){
    void** result = calloc(height, sizeof(void*));
    if(result == NULL){
        return NULL;
    }
    for(size_t i = 0; i < height; i++){
        result[i] = malloc(width * elem_size);
        if(result[i] == NULL){
            //cleanup allocated memory and then return NULL
            for(int j = 0; j < i; j++){
                free(result[j]);
            }
            free(result);
            return NULL;
        }
    }
    return result;
}


// free heap memory for a 2-D matrix matrix with height height.
void free_matrix(void** matrix, size_t height){
    for(size_t i = 0; i < height; i++){
        free(matrix[i]);
    }
    free(matrix);
}

// getting input file path and output file path from command line by options -i for input, and -o for 
// output
void get_files(char** inputfile, char** outputfile, int argc, char* argv[], size_t filename_length,
    int* opt_l, size_t* line_num, char** line_highlight_file_h, char** line_highlight_file_v){
    int index;
    int c;
    while((c = getopt(argc, argv, "i:o:l:h:v:")) != -1){
        switch(c){
            case 'i': 
                *inputfile = optarg;
                break; 
            case 'o':
                *outputfile = optarg;
                break;
            case 'l':
                *opt_l = 1;
                *line_num =atoi(optarg);
                break;
            case 'h': 
                *line_highlight_file_h = optarg;
                break;
            case 'v': 
                *line_highlight_file_v = optarg;
                break;
            case '?': 
                if(optopt == 'i' | optopt == 'o' | optopt == 'l' | optopt == 'h' | optopt == 'v')
                    fprintf(stderr, "Option -%c requires an argument.\n", optopt);
                else if (isprint (optopt))
                    fprintf (stderr, "Unknown option `-%c'.\n", optopt);
                else
                    fprintf (stderr, "Unknown option character `\\x%x'.\n", optopt);
                exit(1);
            default:
                abort();
        }
    }

    for (index = optind; index < argc; index++){
        printf ("Non-option argument %s\n", argv[index]);
        exit(1);
    }

}

// returns -1 if specified highlight is out of matrix bound; 0, otherwise.
int check_highlight_bound(size_t height, int opt_l, size_t line_num){
    if(opt_l && line_num >= height){
        return -1;
    }
    return 0;
}

// returns an array of length height, with 0s and 1s; array[i] == 1 means the ith row should be highlighted
char* parse_highlights(FILE* highlight_fstream, size_t height){ 
    size_t num;
    char* highlights = (char*)alloc_array(height, sizeof(char));
    if(highlights == NULL){
        perror("can't malloc\n"); 
        exit(1);

    }
    while (fscanf(highlight_fstream, "%zd", &num) == 1){
        // comparison of num < 0 is always false
        if(num >= height){
            perror("at least one of the lines specified in the given file is out of bound\n");
        }
        highlights[num] = 1;
    }
    return highlights;
}


