program IsSumEven;

uses crt;

var a, b, x: integer;

function is_sum_even(a, b: integer): boolean;
begin
	if ( ((a + b) mod 2) = 0 ) then
		is_sum_even := True
	else
		is_sum_even := False;
end;

begin
	clrscr;
	
	a := MAXINT;
	b := MAXINT;
	x := MAXINT;
	
	while (x <> 777) do begin
		if (x < a) then			if (a > b) then
				a := x
			else
				b := x
		else
			if (b > a) then
				b := x
			else
				a := x;
		write('Input x: ');
		read(x);
		writeln('The input was: ', x);
	end;
	
	write('The sum of ', a, ' and ', b, ' is ');
	if is_sum_even(a, b) then
		writeln('even.')
	else
		writeln('odd.');end.