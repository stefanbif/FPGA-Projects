

# ADDER RTL VIEWER:
- its an example of how the modules for the adder from lab three go together
- I pasted it here for now because the modules for the counter program goes together in the same way
![image](https://user-images.githubusercontent.com/73149111/201182861-941be672-5531-49f6-8797-8bf0ac833e66.png)

# Counter Pin Assignment:
- the full pin assignment is in the .csv file
![image](https://user-images.githubusercontent.com/73149111/201393794-15340aef-1a4a-45fa-bc90-eff7aa8c27a7.png)



# Test Toggle and Reset
- reset = 0 between t=500ns and t=1500ns
- toggle = 1 from t=0 to t=3000ns
  - counting up
- toggle = 0 after t=3000ns 
  - counting down
![image](https://user-images.githubusercontent.com/73149111/203878855-6f96b118-ce33-48b6-9ec0-e4c7c9e75edc.png)

- toggle = 1 from t=7000 to t=9000ns
  - counting up
- toggle = 0 from t=9000ns to t=11000ns
  - counting down
- toggle = 1 after t=11000ns 
  - counting up
- Enable = 0 after t=12000ns
  - counting stops
![image](https://user-images.githubusercontent.com/73149111/203879301-ad99a04d-be67-40b3-98b1-d0cb726d2236.png)


# Counter RTL Viewer
![image](https://user-images.githubusercontent.com/73149111/203880950-0c414b19-d82b-4bc7-96cb-157351e14cfd.png)
