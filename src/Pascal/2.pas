program SumOfDigits;

uses	crt,
	Strings,
	SysUtils;

var
	input_str: string;
	A: TStringDynArray;

function CountByChars(A: TStringDynArray): integer;
var
	i: integer;
	d: char;
	acc: integer = 0;
begin
	for i:=Low(A) to High(A) do
		for d in A[i] do
			acc := acc + StrToInt(d);
	CountByChars := acc;
end;

function CountByDivision(A: TStringDynArray): integer;
var
	i, n: integer;
	acc: integer = 0;
begin
	for i:=Low(A) to High(A) do
	begin
		n := StrToInt(A[i]);
		while (n <> 0) do
		begin
			Inc(acc, n mod 10);
			n := n div 10;
		end;
	end;
	CountByDivision := acc;
end;



begin
	clrscr;

	write('Space-separated list of non-negative integers: ');
	readln(input_str);

	A := Split(input_str);

	writeln('[Counting by characters] The sum of all digits in every number is: ', CountByChars(A));
	writeln('[Counting by division by 10] The sum of all digits in every number is: ', CountByDivision(A));
end.
