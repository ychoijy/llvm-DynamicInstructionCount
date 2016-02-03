#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#define MAX_NUM		1000
#define MAX_ARR		1000000

void merge(int arr[],int min,int mid,int max)
{
	int tmp[MAX_ARR];
	int i,j,k,m;


	j=min;
	m=mid+1;
	for(i=min; j<=mid && m<=max ; i++)
	{
		if(arr[j]<=arr[m])
		{
			tmp[i]=arr[j];
			j++;
		}
		else
		{
			tmp[i]=arr[m];
			m++;
		}
	}
	if(j>mid)
	{
		for(k=m; k<=max; k++)
		{
			tmp[i]=arr[k];
			i++;
		}
	}
	else
	{
		for(k=j; k<=mid; k++)
		{
			tmp[i]=arr[k];
			i++;
		}
	}
	for(k=min; k<=max; k++)
		arr[k]=tmp[k];
}

void part(int arr[],int min,int max)
{
	int mid;
	if(min<max)
	{
		mid=(min+max)/2;
		part(arr,min,mid);
		part(arr,mid+1,max);
		merge(arr,min,mid,max);
	}
}

int main()
{
	int arr[MAX_ARR];
	int i,size;

	srand(time(NULL));

	printf("\n\t------- Merge sorting method -------\n\n");
	printf("Enter total no. of elements : ");
	scanf("%d", &size);
	for(i=0; i<size; i++)
	{
		arr[i] = rand() % MAX_NUM;
		printf("%d, ", arr[i]);
	}
	part(arr,0,size-1);
	printf("\n\t------- Merge sorted elements -------\n\n");
	for(i=0; i<size; i++)
		printf("%d\n", arr[i]);
	return 0;
}






