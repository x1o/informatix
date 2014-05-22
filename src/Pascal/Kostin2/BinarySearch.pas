program BinarySearch;

const N = 5;

type
	IntArr = array [1..N] of integer;

var
	A: IntArr;
	i, el: integer;

function BinSearch(A: IntArr; el: integer): integer;
var
	mid, left, right: integer;
begin
	left := 1;
	right := N;
	while  left < right do
	begin
		mid := (right + left) div 2;
		if A[mid] < el then
			left := mid + 1
		else
			right := mid
	end;
	if A[left] <> el then
		left := -1;
	BinSearch := left;
end;

begin
	for i:=1 to n do
		read(A[i]);
	readln(el);
	writeln(BinSearch(A, el));
end.
