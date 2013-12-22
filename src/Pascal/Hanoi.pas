program Hanoi;

const
	N = 3;

type
	Disk = 1..N;
	Peg = record
		top_i:	0..N;
		arr:	array [1..N] of Disk;
	end;
	Pegs = array [1..3] of Peg;


procedure push(var p: Peg; x: Disk);
begin
	if p.top_i = N then
	begin
		writeln('Error: ', x, ': Cannot push more!');
		halt;
	end;
	p.top_i := p.top_i + 1;
	p.arr[p.top_i] := x;
end;

function pop(var p: Peg): Disk;
begin
	if p.top_i = 0 then
	begin
		writeln('Error: The stack is empty.');
		halt;
	end;
	p.top_i := p.top_i - 1;
	exit(p.arr[p.top_i+1]);
end;

function peek(p: Peg): Disk;
begin
	exit(p.arr[p.top_i]);
end;

procedure show(p: Peg);
var
	i: integer;
begin
	for i:=1 to 2*N do
		write('-');
	writeln();
	{ for i:=p.top_i downto 1 do }
	for i:=1 to p.top_i do
		write(p.arr[i], ' ');
	writeln();
	for i:=1 to 2*N do
		write('-');
	writeln();
end;

procedure ShowPegs(px: Pegs);
var
	i: 1..3;
begin
	writeln('.');
	for i:=1 to 3 do
	begin
		show(px[i]);
	end;
	writeln('.');
end;

procedure MoveP(var px: Pegs; from_p: integer; idx: Disk; to_p: integer);
var
	other_p: 1..3;
begin
	ShowPegs(px);
	if idx = peek(px[from_p]) then
		push(px[to_p], pop(px[from_p]))
	else
	begin
		other_p := 6 - from_p - to_p;
		MoveP(px, from_p, idx - 1, other_p);
		MoveP(px, from_p, idx, to_p);
		MoveP(px, other_p, idx-1, to_p);
	end;
end;

var
	i: 0..N;
	a, b, c: Peg;
	px: Pegs;

begin
	{ px[1].top_i := 0; }
	for i:=N downto 1 do
	begin
		push(px[1], i);
	end;

	ShowPegs(px);

	MoveP(px, 1, N, 3);
	ShowPegs(px);
end.
