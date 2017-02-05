#include "World.h"
#include "../Utils/FreeImage.h"
#include "../Utils/FreeImagePlus.h"
#include <cstdio>

void saveSceneToFile(World *w, std::string filename) {
	printf("Saving image in file \"%s\"\n\t", filename.c_str()); fflush(stdout);
	fipImage img(FIT_BITMAP, w->vp.res.x, w->vp.res.y, 24);
	BYTE* ptr = img.accessPixels();
	int pitch = img.getScanWidth();
	int bmask = FreeImage_GetBlueMask(img);
	int rmask = FreeImage_GetRedMask(img);
	int r = 0, b = 2;
	if (rmask > bmask) {
		r = 2; b = 0;
	}
	float3 a0 = make_float3(0, 0, 0);
	float3 a1 = make_float3(1, 1, 1);
	for(int k = 0; k < w->vp.res.y; ++k)
		for (int i = 0; i < w->vp.res.x; ++i) {
			float3 v = clamp(w->image[i + k * w->vp.res.x], a0, a1) * 255.0f;
			ptr[pitch * k + 3 * i + r] = (unsigned char)(v.x);
			ptr[pitch * k + 3 * i + 1] = (unsigned char)(v.y);
			ptr[pitch * k + 3 * i + b] = (unsigned char)(v.z);
		}
	img.save(filename.c_str());
	img.clear();
	printf("OK\n"); fflush(stdout);
}
