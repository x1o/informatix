program SelectionSort;

uses
	crt,
	Matrix2D;

var
	i, t, min_i, frontier_i: integer;
	S: string;
	A: TIntDynArray;

begin
	write('Space-separated list of integers: ');
	readln(S);
	A := StringToIntArray(S);

	for frontier_i:=0 to Length(A)-2 do
	begin
		min_i := frontier_i;
		for i:=(frontier_i+1) to Length(A)-1 do
			if A[i] < A[min_i] then
				min_i := i;
		t := A[frontier_i];
		A[frontier_i] := A[min_i];
		A[min_i] := t;
	end;

	PrintArray(A, ' ');
end.
