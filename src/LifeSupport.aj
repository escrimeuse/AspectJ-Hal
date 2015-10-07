
public aspect LifeSupport {
	declare precedence: LifeSupport, Authorization;
	
	private boolean Crew.alive = true; 
	
	public int Crew.getLifeStatus() {
		if (this.alive == true) return 1;
		else return 0;
	}
	
	public String Crew.kill() {
		this.alive = false;
		return "You are being retired " + this;
	}
	
	pointcut allVoidMessages(OnBoardComputer computer, Crew crew): call(void OnBoardComputer.*(..)) && target(computer) && this(crew) && !within(LifeSupport);
	pointcut allStringMessages(OnBoardComputer computer, Crew crew): call(String OnBoardComputer.*(..)) && target(computer) && this(crew) && !within(LifeSupport) ;
	
	void around(OnBoardComputer computer, Crew crew): allVoidMessages(computer,crew) {
		
		if (crew.getLifeStatus() == 1) {
			proceed(computer,crew);
		}
		else {
			// do nothing
		}
	}
	
	String around(OnBoardComputer computer, Crew crew): allStringMessages(computer,crew) {
		if (crew.getLifeStatus() == 1) {
			return proceed(computer,crew);
		}
		else return "";
	}
	
	

}
