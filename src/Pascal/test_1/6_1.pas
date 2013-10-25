program MergeTwoArrays16;

uses
	Matrix2D;

var
	M1, M2: array[0..15] of integer;
	M3: array[0..31] of integer;
	i: integer;

procedure BubbleSort(var A: array of integer);
var
	i, j, t: integer;
begin
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
end;
	
begin
	Randomize;
	for i:=0 to 15 do
		M1[i] := Random(100);
	for i:=0 to 15 do
		M2[i] := Random(100);
	
	PrintArray(M1, ' ');
	PrintArray(M2, ' ');
	
	for i:=0 to 15 do
		M3[i] := M1[i];
		
	for i:=0 to 15 do
		M3[15+i] := M2[i];
		
	BubbleSort(M3);
	
	PrintArray(M3, ' ');
end.