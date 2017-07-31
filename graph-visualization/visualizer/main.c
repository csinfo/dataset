//
//  main.c
//  generateBMP
//
//  Created by Michael Hahn on 6/5/17.
//  Copyright © 2017 Michael Hahn. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <inttypes.h>
#include <math.h>
#include <errno.h>

// #define WIDTH 7840//in pixels
// #define HEIGHT 7840 //in pixels
#define FILENAME "/Users/DongyuLi/Desktop/Interns17/graph-visualization/output/graph1_auto_width.bmp"
#define INPUTFILE "/Users/DongyuLi/Desktop/Interns17/graph-visualization/edgelist/edgelist1.txt"

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

void** alloc_matrix(size_t height, size_t width, size_t elem_size){
    void** result = malloc(height * sizeof(void*));
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

void free_matrix(void** matrix, size_t height){
    for(size_t i = 0; i < height; i++){
        free(matrix[i]);
    }
    free(matrix);
}


int main(int argc, const char * argv[]) {
    FILE * input;
    size_t WIDTH = 0;
    size_t HEIGHT = 0;
    size_t max_node = 0;
    size_t from, to;
    char line[100];
    char array[24];
    char * token;
    char * colortoken;
    uint64_t fromlabel, tolabel, edgelabel;

    FILE * output;
    unsigned int bitmapfileheader[3]; //combined bfReserved1 and bfReserved2
    unsigned int bitmapinfoheader[9]; //no biPlanes or biBitCount as they are shorts not ints
    int extrapaddingperline; //number of bytes that are just paddings for each horizontal line so that are multiples of 4
    int totalsize; //total size in bytes of this bmp file
    int x, y, n;
    unsigned int mixed;
    int red, green, blue;


    // * produce matrix of pixel data from edgelist
    //open the file to read edge list
    input = fopen(INPUTFILE, "r");
    if (input == NULL) {
        perror("Error opening input file\n");
        return -1;
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
    WIDTH = max_node + 1; 
    HEIGHT = WIDTH;
    printf("width == height == %d\n", (int)WIDTH);
    
    // uint64_t frompixels[WIDTH][HEIGHT];
    // uint64_t topixels[WIDTH][HEIGHT];   
    //uint64_t edgepixels[WIDTH][HEIGHT];
    uint64_t** frompixels = (uint64_t**)alloc_matrix(HEIGHT, WIDTH, sizeof(uint64_t));
    uint64_t** topixels = (uint64_t**)alloc_matrix(HEIGHT, WIDTH, sizeof(uint64_t));
    uint64_t** edgepixels = (uint64_t**)alloc_matrix(HEIGHT, WIDTH, sizeof(uint64_t));
    if(!frompixels | !topixels | !edgepixels){
        perror("Error opening ouput file\n"); 
        return -1;
    }



    //initialize all pixels to 0
    for (x = 0; x < WIDTH; x++) {
        for (y = 0; y < HEIGHT; y++) {
            frompixels[x][y] = 0;
            topixels[x][y] = 0;
            edgepixels[x][y] = 0;
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
    

    printf("here 1\n");
    // * produce dmp file
    //determine the extra padding size per line
    extrapaddingperline = 4 - ((WIDTH * 3) % 4);
    if (extrapaddingperline == 4) extrapaddingperline = 0;
    
    //determine total size of the graph, excluding header size
    totalsize = ((WIDTH * 3) + extrapaddingperline) * HEIGHT;
    
    //bitmap file header
    //First two bytes are `B` and `M`
    bitmapfileheader[0] = totalsize + 54; //bfSize (header + contents)
    bitmapfileheader[1] = 0; //bfReserved1 + bfReserved2
    bitmapfileheader[2] = 54; //bfOffBits
    
    //bitmap info header
    bitmapinfoheader[0] = 40; //biSize
    bitmapinfoheader[1] = WIDTH; //biWidth
    bitmapinfoheader[2] = WIDTH; //biHeight
    //Skip biPlanes and biBitCount since they are shorts
    bitmapinfoheader[3] = 0; //biCompression
    bitmapinfoheader[4] = totalsize; //biSizeImage; it is okay to set it to 0 if no compression
    bitmapinfoheader[5] = 0; //biXPelsPerMeter
    bitmapinfoheader[6] = 0; //biYPelsPerMeter
    bitmapinfoheader[7] = 0; //biClrUsed
    bitmapinfoheader[8] = 0; //biClrImportant
    
    //open the file and start writing to the file
    output = fopen(FILENAME, "wb");
    if (output == NULL) {
        perror("Error opening ouput file\n"); 
        return -1;
    }
    

    printf("here 2\n");

    //write bitmap file header to the file
    // printf("here 2.1\n");
    fprintf(output, "BM");
    // printf("here 2.2\n");
    for (n = 0; n < 3; n++) {
        // printf("n=%d\n", n);
        fprintf(output, "%c", bitmapfileheader[n] & 0x000000FF);
        fprintf(output, "%c", (bitmapfileheader[n] & 0x0000FF00) >> 8);
        fprintf(output, "%c", (bitmapfileheader[n] & 0x00FF0000) >> 16);
        fprintf(output, "%c", (bitmapfileheader[n] & (unsigned int) 0xFF000000) >> 24);
    }
    
    printf("here 3\n");
    //write bitmap info header to the file
    for (n = 0; n < 3; n++) {
        fprintf(output, "%c", bitmapinfoheader[n] & 0x000000FF);
        fprintf(output, "%c", (bitmapinfoheader[n] & 0x0000FF00) >> 8);
        fprintf(output, "%c", (bitmapinfoheader[n] & 0x00FF0000) >> 16);
        fprintf(output, "%c", (bitmapinfoheader[n] & (unsigned int) 0xFF000000) >> 24);
    }

    printf("here 4\n");
    //biPlanes and biBitCount fields.
    fprintf(output, "%c", 1); //must be set to 1
    fprintf(output, "%c", 0);
    fprintf(output, "%c", 24); //24 bits per pixel, a total of 16.7 million colors
    fprintf(output, "%c", 0);
    
    printf("here 5\n");
    for (n = 3; n < 9; n++) {
        fprintf(output, "%c", bitmapinfoheader[n] & 0x000000FF);
        fprintf(output, "%c", (bitmapinfoheader[n] & 0x0000FF00) >> 8);
        fprintf(output, "%c", (bitmapinfoheader[n] & 0x00FF0000) >> 16);
        fprintf(output, "%c", (bitmapinfoheader[n] & (unsigned int) 0xFF000000) >> 24);
    }

    //headers are done. Write data now
    for (y = HEIGHT - 1; y >= 0; y--) { //BMP images are proceeded from the bottom to the top
        for (x = 0; x < WIDTH; x++) {
            //fprintf(stdout, "%llu\n", frompixels[x][y]);
            if(frompixels[x][y] == 0 && topixels[x][y] == 0 && edgepixels[x][y] == 0){
                red = 0; 
                green = 0; 
                blue = 0;
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
    free_matrix((void**)frompixels, HEIGHT);
    free_matrix((void**)topixels, HEIGHT);
    free_matrix((void**)edgepixels, HEIGHT);
    
    return 0;
}
