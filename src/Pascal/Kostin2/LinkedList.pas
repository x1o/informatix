program LinkedListLinear;

type
	value = integer;
	elem_ptr = ^element;
	element = record
		val:	value;
		next:	elem_ptr;
	end;

var
	L, p: elem_ptr;
	y: ^word;

procedure printList(p: elem_ptr);
begin
	while p <> nil do
	begin
		write(p^.val, ' ');
		p := p^.next;
	end;
	writeln();
end;

procedure createListFromNTo1(var beg: elem_ptr);
var
	p: elem_ptr;
	x: value;
begin
	beg := nil;
	read(x);
	while x <> 0 do
	begin
		new(p);
		p^.val := x;
		p^.next := beg;
		beg := p;
		read(x);
	end;
end;

procedure createListFrom1ToN(var start_p: elem_ptr);
var
	x: value;
	p: elem_ptr;
begin
	start_p := nil;
	read(x);
	if x<>0 then
	begin
		new(p);
		p^.val := x;
		start_p := p;
		read(x);
		while x<>0 do
		begin
			new(p^.next);
			p := p^.next;
			p^.val := x;
			read(x);
		end;
		p^.next := nil;
	end;
end;

begin
	createListFrom1ToN(L);
	{ createListFromNTo1(L); }
	printList(L);

	{ L := nil; }
	{ y := @L; }
	{ writeln(y^); }

	{ new(p); }
	{ L := p; }
	{ y := @p; }
	{ writeln(y^); }
	{ y := @L; }
	{ writeln(y^); }
	{ L^.val := 88; }
	{ writeln(L^.val); }
	{ p^.val := 77; }
	{ writeln(L^.val); }
end.
