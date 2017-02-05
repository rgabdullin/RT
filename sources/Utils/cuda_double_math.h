#ifndef __cuda_double_math__
#define __cuda_double_math__

#include "vector_types.h"
#include "cuda_math.h"

inline __host__ __device__ double3 make_double3(float x, float y, float z)
{
	double3 d = { x, y, z };
	return d;
}
inline __host__ __device__ double3 make_double3(float3 a)
{
	return make_double3(a.x, a.y, a.z);
}
inline __host__ __device__ float3 make_float3(double3 a)
{
	return make_float3((float)(a.x), (float)(a.y), (float)(a.z));
}
inline __host__ __device__ double3 cross(double3 a, double3 b)
{
	return make_double3(a.y*b.z - a.z*b.y, a.z*b.x - a.x*b.z, a.x*b.y - a.y*b.x);
}

inline __host__ __device__ double3 operator-(double3 &a)
{
	return make_double3(-a.x, -a.y, -a.z);
}

inline __host__ __device__ double3 operator+(double3 a, double3 b)
{
	return make_double3(a.x + b.x, a.y + b.y, a.z + b.z);
}
inline __host__ __device__ void operator+=(double3 &a, double3 b)
{
	a.x += b.x;
	a.y += b.y;
	a.z += b.z;
}

inline __host__ __device__ double3 operator-(double3 a, double3 b)
{
	return make_double3(a.x - b.x, a.y - b.y, a.z - b.z);
}
inline __host__ __device__ void operator-=(double3 &a, double3 b)
{
	a.x -= b.x;
	a.y -= b.y;
	a.z -= b.z;
}
inline __host__ __device__ double3 operator*(double3 a, double3 b)
{
	return make_double3(a.x * b.x, a.y * b.y, a.z * b.z);
}
inline __host__ __device__ double3 operator*(double a, double3 b)
{
	return make_double3(a * b.x, a * b.y, a * b.z);
}
inline __host__ __device__ double3 operator*(double3 a, double b)
{
	return make_double3(b * a.x, b * a.y, b * a.z);
}
inline __host__ __device__ double3 operator/(double3 a, double b)
{
	return make_double3(a.x / b, a.y / b, a.z / b);
}
inline __host__ __device__ void operator*=(double3 &a, double3 b)
{
    a.x *= b.x;
    a.y *= b.y;
    a.z *= b.z;
}
inline __host__ __device__ double3 operator/(double3 a, double3 b)
{
	return make_double3(a.x / b.x, a.y / b.y, a.z / b.z);
}
inline __host__ __device__ void operator/=(double3 &a, double3 b)
{
	a.x /= b.x;
	a.y /= b.y;
	a.z /= b.z;
}
inline __host__ __device__ double dot(double3 a, double3 b)
{
    return a.x * b.x + a.y * b.y + a.z * b.z;
}
inline __host__ __device__ double length(double3 v)
{
	return sqrt(dot(v, v));
}
inline __host__ __device__ double3 normalize(double3 v)
{
	float invLen = 1.0 / sqrt(dot(v, v));
	return v * invLen;
}

#endif