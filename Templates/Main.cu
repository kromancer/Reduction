
__host__ void dummy_input(int *input, int size)
{
  for(int i=0; i<size; i++)
    input[i]=1;
}

int  main(int argc, char** argv)
{
  int *d_input, *d_output;
  int *input, *partial_result;
  int width,height,size;


  dim3 block,grid;


  width   = 1024;
  height  = 1024;
  if (argc>2)
  {
    width   = atoi(argv[1]);
    height  = atoi(argv[2]);
  }
  size = width*height;
 
  block.x = TBLOCK_SIZE;
  grid.x  = ( ( size + block.x - 1 ) / ( block.x * DB_PER_TB ) );


  input          = (int *)malloc(size  *sizeof(int));
  partial_result = (int *)malloc(grid.x*sizeof(int));
  cudaMalloc( (void **)&d_input,     size*sizeof(int));
  cudaMalloc( (void **)&d_output,    grid.x*sizeof(int));

  dummy_input(input,size);  

  cudaMemcpy(d_input, input, size*sizeof(int), cudaMemcpyHostToDevice);
  reduce<TBLOCK_SIZE><<<grid, block>>>(d_input, d_output, size);
  cudaMemcpy(partial_result, d_output, grid.x*sizeof(int), cudaMemcpyDeviceToHost);


  int result = 0;
  for (int i=0; i<grid.x; i++)
    result += partial_result[i];


  return EXIT_SUCCESS;
}