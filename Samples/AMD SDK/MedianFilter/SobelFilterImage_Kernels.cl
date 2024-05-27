__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_LINEAR; 

__kernel void sobel_filter(__read_only image2d_t inputImage, __write_only image2d_t outputImage)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));
	
	float tablica[3*3] = {0};
	for(int i = 0; i < 3; i++){
		for(int j = 0; j < 3; j++){
			float4 pixel = convert_float4(read_imageui(inputImage, imageSampler, (int2)(coord.x + j - 1, coord.y + i - 1)));
			tablica[i*3+j] = pixel.x;
		}
	}
	bool swapped = 1;
	float temp = 0.0f;
	while(swapped){
		swapped = 0;
		for(int i = 1; i < 9; i++){
			if(tablica[i] < tablica[i-1]){
				temp = tablica[i];
				tablica[i] = tablica[i-1];
				tablica[i-1] = temp;
				swapped = 1;
			}
		}
	}
	write_imageui(outputImage, coord, (uint)tablica[4]); // obraz zbinaryzowany		
}