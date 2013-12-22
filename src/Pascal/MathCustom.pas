unit MathCustom;

interface

function Factorial(n: integer): integer;
function Fibonacci(n: integer): integer;
function FibonacciNaive(n: integer): integer;



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

end.
