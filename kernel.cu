#include <iostream>
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/reduce.h>

using namespace std; 
const int N = 10000000;

template<typename T>
struct square
{
    __device__ __host__ T operator ()(const T& x) const
    {
        return x * x;
    }
};




int main()
{
    thrust::device_vector<int> d(N);
    thrust::fill(d.begin(), d.end(), 3);
   

    // find the sum
    //unsigned __int64 sum = thrust::reduce(d.begin(), d.end(), 0, thrust::plus<int>());
    unsigned __int64 sum = thrust::transform_reduce(d.begin(), d.end(), square<int>(), 0, thrust::plus<int>());

    cout << "Sum is: " << sum << endl;

    return 0;
}