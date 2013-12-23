unit LinkedList;



interface

const
	N = 5;

type
	TLinkedList	= array [0..N] of 0..N;

procedure PrintLL(ll: TLinkedList);
procedure InsertLL(var ll: TLinkedList; el: integer; after_el: integer);
function GetNthLL(ll: TLinkedList; m: integer): integer;



implementation

procedure PrintLL(ll: TLinkedList);
var
	i: 0..N;
begin
	i := 0;
	while ll[i] <> 0 do
	begin
		write(ll[i]);
		if ll[ll[i]] <> 0 then { ||||| }
			write(' -> ');
		i := ll[i];
	end;
	writeln();
end;

procedure InsertLL(var ll: TLinkedList; el: integer; after_el: integer);
begin
	ll[el] := ll[after_el];
	ll[after_el] := el;
end;

function GetNthLL(ll: TLinkedList; m: integer): integer;
var
	i, k: 0..N;
begin
	k := 0;
	i := 0;
	while i < m do
	begin
		k := ll[k];
		i := i + 1;
	end;
	exit(k);
end;

end.
