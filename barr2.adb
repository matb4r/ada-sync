with text_io;
use text_io;

procedure barr2 is

	protected Barrier is
		entry register;
	private
		entry await;
		count : integer := 3;
	end Barrier;

	protected body Barrier
	is
		entry register when true is
		begin
			count := count - 1;
			requeue await;
		end;

		entry await when count = 0 is
		begin
			null;
		end;
	end Barrier;

	task type Zad;
	task body Zad is
	begin
		delay 1.0;
		Barrier.register;
	end;

	z1, z2, z3 : Zad;

begin
	null;
end barr2;
