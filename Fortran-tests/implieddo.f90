program implieddo
implicit none

double precision :: array(4) = (/ 1.d0, 2.d0, 3.d0, 4.d0 /)


integer :: i, j

do i=1,4
print*,array(i)

enddo

end
