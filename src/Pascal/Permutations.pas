program Permutations;

{ Most algorithms are due to Kostin;
  See his "Combinatorics' Algorithms", 1997 notes }

{ Code reuse?  Never heard. }

uses
	crt,
	LinkedList;

const
	N = 5;

type
	TBoolArr	= array [1..N] of boolean;
	TPermN		= array [1..N] of 0..N;	{ 0 won't really hurt }
	TPermC		= array [1..N] of -N..N;
	TPermK		= array [1..N] of 1..N; { K for Kanonical! }
	TInvArr		= array [1..N] of 0..(N-1);

var
	a: TBoolArr;
	p, q, r, s: TPermN;
	t, u, v, w: TPermC;
	x, y: TPermK;
	b, c, d: TInvArr;
	i: integer;
	ll: TLinkedList;

procedure PrintPermN(var p: TPermN);
var
	i: 1..N;
begin
	write('<');
	for i := 1 to N-1 do
		write(p[i], ', ');
	writeln(p[n], '>');
end;

{ UGH }
procedure PrintBoolArr(var p: TBoolArr);
var
	i: 1..N;
begin
	write('(');
	for i := 1 to N-1 do
		write(p[i], ', ');
	writeln(p[n], ')');
end;

{ UGH }
procedure PrintPermC(var p: TPermC);
var
	i: 1..N;
begin
	write('[');
	for i := 1 to N-1 do
		write(p[i], ', ');
	writeln(p[n], ']');
end;

{ UGH! }
procedure PrintPermK(var p: TPermK);
var
	i: 1..N;
begin
	write('(');
	for i := 1 to N-1 do
		write(p[i], ', ');
	writeln(p[n], ')');
end;

procedure PrintInvArr(var p: TInvArr);
var
	i: 1..N;
begin
	write('/');
	for i := 1 to N-1 do
		write(p[i], ', ');
	writeln(p[n], '/');
end;

function IsValidPermN(p: TPermN): boolean;
var
	a: array [1..N] of boolean;
	i: 1..N;
begin
	for i:=1 to N do
		a[i] := True;
	i := 1;
	while (i <= N) and a[p[i]] do
	begin
		a[p[i]] := False;
		i := i+1;
	end;
	exit(N = i-1);
end;

{ I really and honestly do not know how to avoid code duplication like this in
  Pascal. }
function IsValidPermC(p: TPermC): boolean;
var
	a: array [1..N] of boolean;
	i: 1..N;
begin
	{ First component begins the cycle,
	  so should be negative. }
	if p[1] > 0 then
		exit(False);
	for i:=1 to N do
		a[i] := True;
	i := 1;
	while (i <= N) and a[Abs(p[i])] do
	begin
		a[p[i]] := False;
		i := i+1;
	end;
	exit(N = i-1);
end;

{ Verbatim copy of IsValidPermN }
function IsValidPermK(p: TPermK): boolean;
var
	a: array [1..N] of boolean;
	i: 1..N;
begin
	for i:=1 to N do
		a[i] := True;
	i := 1;
	while (i <= N) and a[p[i]] do
	begin
		a[p[i]] := False;
		i := i+1;
	end;
	exit(N = i-1);
end;

function IsValidInvArr(a: TInvArr): boolean;
var
	i: 1..N;
begin
	for i:=1 to N do
		if a[i] > n-i then
			exit(False);
	exit(True);
end;


operator - (p: TPermN) q: TPermN;	overload;
var
	i: 1..N;
begin
	for i:=1 to N do
		q[p[i]] := i;
end;

operator * (p: TPermN; q: TPermN) s: TPermN;
var
	i: 1..N;
begin
	for i:=1 to N do
		s[i] := p[q[i]];
end;

procedure InvertCycle(var p: TPermC; start_i: integer; end_i: integer);
var
	i: integer;
	temp: 1..N;
begin
	p[start_i] := -p[start_i];
	for i:=0 to (((end_i - start_i) div 2) - 1) do
	begin
		temp := p[start_i+i];
		p[start_i+i] := p[end_i-i];
		p[end_i-1] := temp;
	end;
	p[start_i] := -p[start_i];
end;

procedure inv(var p: TPermC);
var
	i, j: 1..N;
begin
	i := 1;
	j := 2;
	while j < N do
	begin
		if p[j] < 0 then
		begin
			InvertCycle(p, i, j-1);
			i := j;
		end;
		j := j + 1;
	end;
	InvertCycle(p, i, j);
end;

function InvArrInverse(var x: TInvArr): TInvArr;
var
	i, j, k, s: integer;
	next: array [0..N] of integer;
	y: TInvArr;
begin
	for i:=1 to N do
	begin
		y[i] := 0;
		next[i] := i+1
	end;
	next[0] := 1;
	for i:=1 to N-1 do
	begin
		PrintInvArr(y);
		s := 0;
		k := next[0];
		j := x[i];
		while j > 0 do
		begin
			y[k] := y[k] + 1;
			s := k;
			k := next[k];
			j := j - 1;
			PrintInvArr(y);
		end;
		next[s] := next[k];
		writeln();
	end;
	exit(y);
end;

{ operator * (p: TPermN; g: TPermC) f: TPermN;	overload; }
{ f o g -- LTR, f first }
procedure o(var f: TPermN; var g: TPermC);
var
	i, j, k, s: 0..N;
	h: integer;
begin
	k := 0;
	for i:=N downto 1 do
	begin
		j := Abs(g[i]);
		s := 1;
		while j <> f[s] do
			s := s + 1;
		f[s] := k;
		if g[i] < 0 then
		begin
			s := 1;
			while f[s] <> 0 do
				s := s + 1;
			f[s] := j;
			k := 0;
		end
		else
			k := j;
	end
end;

function IsEvenBad(p: TPermN): boolean;
var
	i, j: 1..N;
	sign: boolean;
begin
	sign := True;
	for i:=1 to N-1 do
		for j:=i+1 to N do
			if p[i] > p[j] then
				sign := not(sign);
	exit(sign);
end;

function IsEven(p: TPermN): boolean;
var
	i, j: 1..N;
	a: TBoolArr;
	s: boolean;
begin
	s := True;
	for i:=1 to N do
		a[i] := True;
	for i:=1 to N do
		if a[i] then
		begin
			j := p[i];
			while j <> i do
			begin
				a[j] := False;
				s := not(s);
				j := p[j];
			end;
		end;
	exit(s);
end;

function IsEvenC(p: TPermC): boolean;
var
	i: 1..N;
	sign: boolean;
begin
	sign := True;
	for i:=1 to N do
		if p[i] > 0 then
			sign := not(sign);
	exit(sign);
end;

function IsEvenI(a: TInvArr): boolean;
var
	i: 1..N;
	sign: 0..1;
begin
	for i:=1 to N do
		sign := sign xor (a[i] mod 2);
	if sign = 0 then
		exit(False)
	else
		exit(True);
end;

{ function RunCycle(p: TPermN; start_i: integer; var a: TBoolArr): integer; }
{ var }
	{ i, len: 1..N; }
{ begin }
	{ len := 1; }
	{ i := p[start_i]; }
	{ while i <> start_i do }
	{ begin }
		{ a[i] := False; }
		{ i := p[i]; }
		{ len := len + 1; }
	{ end; }
	{ exit(len); }
{ end; }

{ function IsEven(p: TPermN): boolean; }
{ var }
	{ i, j, len: 1..N; }
	{ a: TBoolArr; }
	{ s: boolean; }
{ begin }
	{ s := True; }
	{ for i:=1 to N do }
		{ a[i] := True; }
	{ for i:=1 to N do }
		{ if a[i] then }
		{ begin }
			{ len := RunCycle(p, i, a); }
			{ if (len mod 2) = 0 then }
				{ s := not(s); }
		{ end; }
	{ exit(s); }
{ end; }

function Id(): TPermN;
var
	i: 1..N;
	p: TPermN;
begin
	for i:=1 to N do
		p[i] := i;
	exit(p);
end;

{ Here's again some code overlapping with IsEven() this time. }
procedure Nat2Cycl(var p: TPermN; var q: TPermC);
var
	i, j, h: 1..N;
	a: TBoolArr;
begin
	for i:=1 to N do
		a[i] := True;
	h := 1;
	for i:=1 to N do
		if a[i] then
		begin
			q[h] := -i;
			h := h + 1;
			j := p[i];
			while j <> i do
			begin
				q[h] := j;
				h := h + 1;
				a[j] := False;
				j := p[j];
			end;
		end;
end;

{ O(n^2)!  O(n) is possible }
procedure Cycl2Nat(var p: TPermC; var q: TPermN);
begin
	q := Id();
	o(q, p);
end;

function Kanon2Cycl(p: TPermK): TPermC;
var
	i, j: integer;
	a: TPermC;
begin
	i := 1;
	j := 1;
	while j <= N do
	begin
		a[j] := p[j];
		if p[j] <= p[i] then
		begin
			a[j] := -a[j];
			i := j;
		end;
		j := j + 1;
	end;
	exit(a);
end;

procedure Nat2Kanon(var f: TPermN; var g: TPermK);
var
	i, j: 0..N;
	a: TBoolArr;
procedure B(k: integer);
begin
	a[k] := False;
	if k <> i then
	begin
		B(f[k]);
		g[j] := k;
		j := j - 1;
	end;
end;
begin
	for i:=1 to N do
		a[i] := True;
	j := n;
	for i:=1 to N do
		if a[i] then
		begin
			B(f[i]);
			g[j] := i;
			j := j - 1;
		end;
end;

function Nat2InvArr(p: TPermN): TInvArr;
var
	i, j: 1..N;
	a: TInvArr;
begin
	for i:=1 to N do
	begin
		a[i] := 0;
		for j:=1 to N do
			if p[j] = i then
				break
			else
				if p[j] > i then
					a[i] := a[i] + 1;
	end;
	exit(a);
end;

function InvArr2Nat_1(r: TInvArr): TPermN;
var
	p: TPermN;
	i, j, k: 0..N;
begin
	for i:=1 to N do
		p[i] := 0;
	for i:=1 to N do
	begin
		k := r[i] + 1;
		j := 0;
		repeat j := j + 1;
			if p[j] = 0 then
				k := k - 1;
		until k = 0;
		p[j] := i;
	end;
	exit(p);
end;

function InvArr2Nat_2(r: TInvArr): TPermN;
var
	ll: TLinkedList;
	p: TPermN;
	i, j, k: 0..N;
begin
	for i:=0 to N do
		ll[i] := 0;
	for i:=N downto 1 do
		InsertLL(ll, i, GetNthLL(ll, r[i]));
	i := 0;
	j := 1;
	while ll[i] <> 0 do
	begin
		p[j] := ll[i];
		i := ll[i];
		j := j + 1;
	end;
	exit(p);
end;

begin
	clrscr();

	p[1] := 3;
	p[2] := 1;
	p[3] := 4;
	p[4] := 3;
	p[5] := 5;

	q[1] := 2;
	q[2] := 3;
	q[3] := 1;
	q[4] := 4;
	q[5] := 5;

	r[1] := 4;
	r[2] := 5;
	r[3] := 1;
	r[4] := 3;
	r[5] := 2;

	t[1] := -1;
	t[2] := 4;
	t[3] := 3;
	t[4] := -2;
	t[5] := 5;

	u[1] := 1;
	u[2] := 4;
	u[3] := 3;
	u[4] := -2;
	u[5] := 5;

	v[1] := -1;
	v[2] := 4;
	v[3] := 3;
	v[4] := 3;
	v[5] := 5;

	x[1] := 2;
	x[2] := 5;
	x[3] := 1;
	x[4] := 4;
	x[5] := 3;

	b[1] := 2;
	b[2] := 3;
	b[3] := 2;
	b[4] := 0;
	b[5] := 0;

	c[1] := 2;
	c[2] := 3;
	c[3] := 4;
	c[4] := 0;
	c[5] := 0;

	d[1] := 2;
	d[2] := 3;
	d[3] := 2;
	d[4] := 1;
	d[5] := 0;

	ll[0] := 4;
	ll[1] := 0;
	ll[2] := 0;
	ll[3] := 2;
	ll[4] := 5;
	ll[5] := 3;

	{ --- Validity --- }
	{ write('p = '); }
	{ PrintPermN(p); }
	{ writeln('p is a valid permutation: ', IsValidPermN(p)); }
	{ write('q = '); }
	{ PrintPermN(q); }
	{ writeln('q is a valid permutation: ', IsValidPermN(q)); }
	{ write('t = '); }
	{ PrintPermC(t); }
	{ writeln('t is a valid permutation: ', IsValidPermC(t)); }
	{ write('u = '); }
	{ PrintPermC(u); }
	{ writeln('u is a valid permutation: ', IsValidPermC(u)); }
	{ write('v = '); }
	{ PrintPermC(v); }
	{ writeln('v is a valid permutation: ', IsValidPermC(v)); }
	{ write('b = '); }
	{ PrintInvArr(b); }
	{ writeln('b is a valid inversion array: ', IsValidInvArr(b)); }
	{ write('c = '); }
	{ PrintInvArr(c); }
	{ writeln('c is a valid inversion array: ', IsValidInvArr(c)); }

	{ --- Operators --- }
	{ PrintPermN(q); }
	{ PrintPermN(r); }
	{ s := q * r; }
	{ PrintPermN(s); }
	{ PrintPermN(q); }
	{ r := -q; }
	{ PrintPermN(r); }
	{ r := q * (-q); }
	{ PrintPermN(r); }
	{ PrintPermN(q); }
	{ Nat2Cycl(r, w); }
	{ PrintPermC(w); }
	{ [> p := q * w; <] }
	{ o(q, w); }
	{ PrintPermN(q); }
	{ PrintPermC(t); }
	{ w := -t; }
	{ PrintPermC(w); }
	{ PrintPermC(t); }
	{ inv(t); }
	{ PrintPermC(t); }
	{ PrintPermN(r); }
	{ PrintInvArr(b); }
	{ c := InvArrInverse(b); }
	{ PrintInvArr(c); }
	{ PrintPermN(r); }
	{ r := -r; }
	{ d := Nat2InvArr(r); }
	{ PrintInvArr(d); }

	{ --- Parity --- }
	{ PrintPermN(q); }
	{ writeln('q is an even permutation: ', IsEvenBad(q), ' ', IsEven(q)); }
	{ PrintPermN(r); }
	{ writeln('r is an even permutation: ', IsEvenBad(r), ' ', IsEven(r)); }
	{ PrintPermC(t); }
	{ writeln('t is an even permutation: ', IsEvenC(t)); }
	{ PrintInvArr(b); }
	{ writeln('b is an even permutation: ', IsEvenI(b)); }
	{ PrintInvArr(d); }
	{ writeln('d is an even permutation: ', IsEvenI(d)); }

	{ --- Conversion --- }
	{ PrintPermN(r); }
	{ Nat2Cycl(r, w); }
	{ PrintPermC(w); }
	{ PrintPermC(t); }
	{ Cycl2Nat(t, s); }
	{ PrintPermN(s); }
	{ PrintPermK(x); }
	{ t := Kanon2Cycl(x); }
	{ PrintPermC(t); }
	{ PrintPermN(q); }
	{ Nat2Kanon(q, x); }
	{ PrintPermK(x); }
	{ PrintPermN(r); }
	{ d := Nat2InvArr(r); }
	{ PrintInvArr(d); }
	{ PrintInvArr(b); }
	{ s := InvArr2Nat_1(b); }
	{ PrintPermN(s); }
	{ PrintInvArr(b); }
	{ s := InvArr2Nat_2(b); }
	{ PrintPermN(s); }

	{ --- Misc --- }
	ll[0] := 0;
	ll[1] := 0;
	ll[2] := 0;
	ll[3] := 0;
	ll[4] := 0;
	ll[5] := 0;

	{ r[1] := 2; }
	{ r[2] := 3; }
	{ r[3] := 2; }
	{ r[4] := 0; }
	{ r[5] := 0; }
	{ for i:=N downto 1 do }
		{ InsertLL(ll, i, GetNthLL(ll, r[i])); }
	{ PrintLL(ll); }

	{ writeln(GetNthLL(ll, 1)); }
	{ InsertLL(ll, 1, 5); }
	{ PrintLL(ll); }
	{ for i:=0 to N do }
		{ ll[i] := 0; }
	{ InsertLL(ll, 5, 0); }
	{ PrintLL(ll); }
	{ InsertLL(ll, 4, 0); }
	{ PrintLL(ll); }
	{ InsertLL(ll, 3, 2); }
	{ PrintLL(ll); }
	{ writeln(GetNthLL(ll, 1)); }
	{ writeln(GetNthLL(ll, 2)); }
	{ writeln(GetNthLL(ll, 3)); }
	{ writeln(GetNthLL(ll, 4)); }
end.
