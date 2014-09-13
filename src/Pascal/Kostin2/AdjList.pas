const
	n = 5;
	mr = 1.0E10;

type
	ptr = ^el;
	el = record
		nom: integer;
		r: real;
		tp: 1..3;
		next: ptr;
	end;

var
	sp: array [1..n] of record
							b: real; { weight? }
							ref: ptr;
						end;
	f: text;
	i, j: integer;
	a: real;
	x, y: ptr;
	t: 1..3;

procedure input;
begin
	assign(f, 'input.txt');
	reset(f);
	while not eof(f) do
	begin
		read(f, i);
		sp[i].b := mr;
		if eoln(f) then
			sp[i].ref := nil
		else
		begin
			read(f, j, a, t);
			new(x);
			x^.nom := j;
			x^.tp := t;
			x^.r := a;
			x^.next := nil;
			sp[i].ref := x;
			while not eoln(f) do
			begin
				read(f, j, a, t);
				new(y);
				y^.nom := j;
				y^.r := a;
				y^.tp := t;
				y^.next := nil;
				x^.next := y;
				x := y;
			end;
		end;
	end;
end;

procedure output;
var
	p: integer;
begin
	writeln;
	for p:=1 to n do
	begin
		write(p: 3, ' ', sp[p].b:9:1, ' ');
		x := sp[p].ref;
		while x <> nil do
		begin
			write(x^.nom:2, x^.r:5:1, x^.tp:2, ' ');
			x := x^.next;
		end;
		writeln();
	end;
end;

begin
	input;
	{ output; }
end.
