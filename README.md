# FPGA-Set

> 2022 Spring  NCKU FPGA Course
>
> Homework 0 Set calculation

## Modules

1. **set** module

   The top module of our homework, combining all the other submodules

2. **controller** module

   Control the signals given by the `testbench.v`, and give the necessary signals to the other modules

3. **coord_gen** module

   Since our work would require few cycles to do the calculation, this module would output the coordinate one by one to the processing element

4. **buffer** module

   Buffer the input from the testbench. Since the testbench signals only exist in a cycle, we need to buffer the input for the future use

5. **PE** module

   The processing element, calculate if the given coordinate is inside of the circles

6. **LU** module

   The logic unit module. According to the given mode and the output from PE module, see if the coordinate satisfy the condition of such mode

7. **ACC** module

   According to all the LU results, accumulate all the satisfied coordinates and give the final output