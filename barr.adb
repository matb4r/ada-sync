with text_io;
use text_io;

procedure barr is

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

	task t1;
	task body t1 is
	begin
		put_line("t1 sleeping 1");
		delay 1.0;
		Barrier.register;
	end;
		
	task t2;
	task body t2 is
	begin
		put_line("t2 sleeping 2");
		delay 2.0;
		Barrier.register;
	end;

	task t3;
	task body t3 is
	begin
		put_line("t3 sleeping 3");
		delay 3.0;
		Barrier.register;
	end;
begin
	null;
end barr;
