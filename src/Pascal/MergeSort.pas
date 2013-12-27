program MergeSort;
{ This is basically a ripoff of the algorithm by Kubo,
  see http://people.ksp.sk/~kuko/pascal/download/mergesort.pas.html }

const
	N = 7;

var
	a, b, c: array [1..N] of integer;
	i: integer;

procedure Merge (l, m, r: integer);
var
	i, j, k: integer;
begin
	for i := l to m do
		b[i] := a[i];
	i := l;
	b[m+1] := MAXINT;
	for j := m+1 to r do
		c[j] := a[j];
	j := m+1;
	c[r+1] := MAXINT;
	k := l;
	while (b[i]<MAXINT) or (c[j]<MAXINT) do
		if b[i]<c[j] then
		begin
			a[k] := b[i];
			inc (i);
			inc(k);
		end
		else
		begin
			a[k] := c[j];
			inc (j);
			inc(k);
		end;
end;

procedure MergeSort (l, r: integer);
var
	m: integer;
begin
	if l < r then
	begin
		m := (l+r) div 2;
		MergeSort(l, m);
		MergeSort(m+1, r);
		Merge(l, m, r);
	end;
end;

procedure PrintA();
var
	i: integer;
begin
	write('(');
	for i:=1 to N do
		write(a[i], ' ');
	writeln(')');
end;

begin
	Randomize;
	for i:=1 to N do
		a[i] := Random(N-1);
	writeln('Sorting this array: ');
	PrintA();
	Mergesort(1, N);
	writeln('Results it: ');
	PrintA();
end.
