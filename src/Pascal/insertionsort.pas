program InsertionSort;

uses
	crt,
	Matrix2D;

var
	i, frontier, frontier_i: integer;
	S: string;
	A: TIntDynArray;

begin
	write('Space-separated list of integers: ');
	readln(S);
	A := StringToIntArray(S);

	for frontier_i:=1 to Length(A)-1 do
	begin
		frontier := A[frontier_i];
		for i:=frontier_i downto 1 do
			if A[i-1] > frontier then
			begin
				A[i] := A[i-1];
				A[i-1] := frontier;
			end;
	end;

	PrintArray(A, ' ');
end.
