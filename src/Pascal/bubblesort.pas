program BubbleSort;

uses
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

	for i:=Length(A) - 1 downto 1 do
	begin
		for j:=0 to i-1 do
		begin
			if A[j] > A[j+1] then
			begin
				t := A[j];
				A[j] := A[j+1];
				A[j+1] := t;
			end;
		end;
	end;

	PrintArray(A, ' ');
end.
