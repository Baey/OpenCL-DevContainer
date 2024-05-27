#define KERNEL_SIZE 5
#define RADIUS 2

__constant sampler_t imageSampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_LINEAR; 

__kernel void sobel_filter(__read_only image2d_t inputImage, __write_only image2d_t outputImage)
{
	int2 coord = (int2)(get_global_id(0), get_global_id(1));

	float prog_binaryzacji = 100.0f;
	float4 wynik_dylatacji = (float4)(0.0f);
	float4 pixel = (float4)(0.0f);
	float4 temp;
	for(int i = -(KERNEL_SIZE/2); i <= (KERNEL_SIZE/2); i++)
	{
		for(int j = -(KERNEL_SIZE/2); j <= (KERNEL_SIZE/2); j++)
		{
			if ((i*i + j*j) <= RADIUS*RADIUS){
				temp = convert_float4(read_imageui(inputImage, imageSampler, (int2)(coord.x + j, coord.y + i)));
				pixel = (float4)(step(prog_binaryzacji, temp.xyz), temp.w);
				wynik_dylatacji = (float4)(max(pixel.xyz, wynik_dylatacji.xyz), temp.w);
			}
		}
	}
	wynik_dylatacji.xyz = wynik_dylatacji.xyz * 255.0f;

	write_imageui(outputImage, coord, convert_uint4(wynik_dylatacji)); // obraz zbinaryzowany		
}