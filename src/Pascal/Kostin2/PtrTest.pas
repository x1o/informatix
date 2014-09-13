type
	{ trp = ^tr; }
	tr = record
		a: string;
		b: integer;
	end;

var
	r: tr;
	{ rp: trp; }
	rp, rp2: ^tr;

begin
	new(rp);
	rp^.a := 'hello';
	rp^.b := 1;
	rp2 := rp;
	rp^.a := 'hi';
	writeln(rp2^.a);
	

	{ new(rp); }
	{ rp^.a := 'hello'; }
	{ rp^.b := 5; }
	{ writeln(rp^.a); }
	{ writeln(rp^.b); }
	{ dispose(rp); }

	{ r.a := 'hi'; }
	{ r.b := 2; }
	{ writeln(r.a); }
	{ writeln(r.b); }
	{ rp := @r; }
	{ rp^.b := 3; }
	{ writeln(r.b); }
end.
