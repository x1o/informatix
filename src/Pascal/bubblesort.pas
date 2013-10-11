program BubbleSort;

uses
	Strings,
	Matrix2D,
	crt;

var
	i, j, t: integer;
	S: string;
	A: TIntDynArray;

begin
	write('Space-separated list of integers: ');
	readln(S);
	A := StringToIntArray(S);

	i := Length(A) - 1;
	while i > 0 do
	begin
		j := 0;
		while (j < i) do
		begin
			if A[j] > A[j+1] then
			begin
				t := A[j];
				A[j] := A[j+1];
				A[j+1] := t;
			end;
			Inc(j);
		end;
		Dec(i);
	end;

	PrintArray(A, ' '); { Worked the first time I compiled it. }
end.
