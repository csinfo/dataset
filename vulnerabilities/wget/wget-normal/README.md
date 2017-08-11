instruction on reproducing wget normal behavior provenance data 

To simulate the normal behavior of wget: run the following line(s)
    ```
    vagrant up 
    ```


If there is a problem with reboot plugin, use wget-normal-run.sh to generate normal behavior data. 
In this case, Vagrantfile's lines 88 through 133 should be commented out.

However, if there is still a problem that vagrant complains, it most likely due to the instability of fedora26.