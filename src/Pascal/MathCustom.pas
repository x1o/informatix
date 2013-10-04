unit MathCustom;

interface

function Factorial(n: integer): integer;



implementation

function Factorial(n: integer): integer;
begin
	if (n = 0) then
		Factorial := 1
	else
		Factorial := n * Factorial(n-1);
end;

end.
