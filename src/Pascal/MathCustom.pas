unit MathCustom;

interface

function Factorial(n: integer): integer;
function Fibonacci(n: integer): integer;
function FibonacciNaive(n: integer): integer;
procedure PrintInt(i: integer);



implementation

function Factorial(n: integer): integer;
begin
	if (n = 0) then
		Factorial := 1
	else
		Factorial := n * Factorial(n-1);
end;

function FibonacciNaive(n: integer): integer;
begin
	case n of
		0: exit(0);
		1: exit(1);
		else exit(FibonacciNaive(n-1) + FibonacciNaive(n-2));
	end;
end;

function Fibonacci(n: integer): integer;
function FibHelper(n, m, f1, f2: integer): integer;
begin
	if n = m then
		exit(f1 + f2)
	else
	begin
		case m of
			0, 1: f1 := 1;
		    else
				begin
					f1 := f1 + f2;
					f2 := f1 - f2;
				end;
		end;
		exit(FibHelper(n, m + 1, f1, f2));
	end;
end;
begin
	exit(FibHelper(n, 0, 0, 0));
end;

{ (c) Kostin }
procedure PrintInt(i: integer);
procedure B(i: integer);
var
	i1: integer;
begin
	if i <> 0 then
	begin
		i1 := i mod 10;
		B(i div 10);
		write(char(ord('0') + i1));
	end;
end;
begin
	if i = 0 then
		write ('0')
	else
	begin
		if i < 0 then
			write('-');
		B(abs(i));
	end;
end;


end.
