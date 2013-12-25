unit MathCustom;

interface

function Factorial(n: integer): integer;
function Fibonacci(n: integer): integer;
function FibonacciNaive(n: integer): integer;
procedure PrintInt(n: integer);
procedure PrintReal(x: real; n: integer);



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

{ The following two procedures are quite pointless and dull. }

{ (c) Kostin }
{ procedure PrintInt(i: integer); }
{ procedure B(i: integer); }
{ var }
	{ i1: integer; }
{ begin }
	{ if i <> 0 then }
	{ begin }
		{ i1 := i mod 10; }
		{ B(i div 10); }
		{ write(char(ord('0') + i1)); }
	{ end; }
{ end; }
{ begin }
	{ if i = 0 then }
		{ write ('0') }
	{ else }
	{ begin }
		{ if i < 0 then }
			{ write('-'); }
		{ B(abs(i)); }
	{ end; }
	{ writeln(); }
{ end; }

{ (c) Kostin }
{ procedure PrintReal(r: real; n: integer); }
{ var }
	{ r1: real; }
{ procedure inter(r: real); }
{ var }
	{ r1: real; }
{ begin }
	{ if r <> 0 then }
	{ begin }
		{ r1 := int(r/10); }
		{ inter(r1); }
		{ write(char(ord('0') + trunc(r-r1*10))); }
	{ end; }
{ end; }
{ procedure fracter(r: real; n: integer); }
{ var }
	{ i: integer; }
{ begin }
	{ for i := 1 to n do }
	{ begin }
		{ r := r*10; }
		{ write(char(ord('0') + trunc(r))); }
		{ r := frac(r); }
	{ end; }
{ end; }
{ begin }
	{ writeln(r); }
	{ if r < 0 then }
		{ write('-'); }
	{ r1 := abs(r); }
	{ if r1 < 1 then }
		{ write('0') }
	{ else }
		{ inter(int(r1)); }
	{ write('.'); }
	{ fracter(frac(r1), n); }
	{ writeln(); }
{ end; }

procedure PrintInt(n: integer);
procedure PrintD(n: integer);
begin
	write(char(ord('0') + n));
end;
var
	d: integer;
begin
	if n < 0 then
	begin
		write('-');
		n := Abs(n);
	end;
	d := n div 10;
	if d = 0 then
		PrintD(n mod 10)
	else
	begin
		PrintInt(d);
		PrintD(n mod 10);
	end;
end;

procedure PrintReal(x: real; n: integer);
procedure PrintFrac(x: real; n: integer);
var
	i: integer;
begin
	writeln(x);
	for i:=1 to n do
	begin
		x := x * 10;
		write(char(ord('0') + trunc(x)));
		x := frac(x);
	end;
end;
begin
	PrintInt(trunc(x));
	write('.');
	x := Abs(x);
	PrintFrac(frac(x), n);
end;

end.
