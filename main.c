#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>

#define FRAME_WIDTH		640
#define FRAME_HEIGHT	480

#define FRAME_BUFFER_DEVICE	"/dev/fb0"

int main()
{

	//RGB16
	int16_t frame[FRAME_HEIGHT][FRAME_WIDTH];

	int max_cX = -700;
	int min_cY = 270;

	int cY_step = -5;
	int cX = -700;	// x = -700~-700
	int cY;			// y = 400~270

	int fd;

	printf( "Function1: Name\n" );
	char * team = NULL ;
	char * name1 = NULL ;
	char * name2 = NULL ;
	char * name3 = NULL ;
	name( team, name1, name2, name3 );
	printf( "Function2: ID\n" );
	int num1, num2, num3 ;
	int sum = 0 ;
	sum = id( num1, num2, num3 );
	printf( "\n\nMain Function:\n" );
	printf( "*****Print All*****\n" );
	printf( "%s", team );
	printf( "%d   %s", num1, name1 );
	printf( "%d   %s", num2, name2 );
	printf( "%d   %s", num3, name3 );
	printf( "ID Summation = %d\n", sum );
	printf( "*****End Print*****\n" );

	printf( "\n***** Please enter p to draw Julia Set animation *****\n" );
	while(getchar()!='p') {}

	system( "clear" );

	fd = open( FRAME_BUFFER_DEVICE, (O_RDWR | O_SYNC) );

	if( fd<0 )
	{	printf( "Frame Buffer Device Open Error!!\n" );	}
	else
	{
		for( cY=400 ; cY>=min_cY; cY = cY + cY_step ) {
			drawJuliaSet( cX, cY, FRAME_WIDTH, FRAME_HEIGHT, frame );
			write( fd, frame, sizeof(int16_t)*FRAME_HEIGHT*FRAME_WIDTH );
			lseek( fd, 0, SEEK_SET );
		}

		printf( ".*.*.*.<:: Happy New Year ::>.*.*.*.\n" );
		printf( "by %s", team );
		printf( "%d   %s", num1, name1 );
		printf( "%d   %s", num2, name2 );
		printf( "%d   %s", num3, name3 );

		close( fd );
	}

	while(getchar()!='p') {}

	return 0;
}

