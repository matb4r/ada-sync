with text_io;
use text_io;

procedure pc_n_protobj2 is

	type myArrayType is array(integer range 0..4) of integer;

	protected Buffer is
		entry insert(item : in integer);
		entry remove(item : out integer);
	private
		stack : myArrayType;
		ptr : integer := 0;
	end Buffer;

	protected body Buffer
	is
		entry insert(item : in integer) when ptr < 5 is
		begin
			stack(ptr) := item;
			ptr := ptr + 1;
		end;

		entry remove(item : out integer) when ptr > 0 is
		begin
			ptr := ptr - 1;
			item := stack(ptr);
		end;
	end Buffer;

	task producer;
	task body producer is
		item : integer := 0;
	begin
		Buffer.insert(item);
		put_line("inserted" & item'img);
	end producer;

	task consumer;
	task body consumer is
		item : integer := 0;
	begin
		Buffer.remove(item);
		put_line("removed" & item'img);
	end consumer;

begin
	null;
end pc_n_protobj2;
