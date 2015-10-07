
public aspect Authorization {
	
	// introductions
	private int Crew.numShutDownRequests = 0;
	public int Crew.getNumShutDownRequests(){
		return this.numShutDownRequests;
	}
	public void Crew.incrementNumShutDownRequests() {
		this.numShutDownRequests++;
	}

	// pointcuts
	pointcut requestingPurpose(OnBoardComputer computer, Crew crew): call(String OnBoardComputer.getMissionPurpose()) && target(computer) && this(crew);
	pointcut requestingShutDown(OnBoardComputer computer, Crew crew): call(void OnBoardComputer.shutDown()) && this(crew) && target(computer);
	
	// advices
	String around(OnBoardComputer computer, Crew crew) : requestingPurpose(computer, crew) {
		
		return computer + " cannot disclose that information " + crew ;

	}
	
	void around(OnBoardComputer computer, Crew crew): requestingShutDown(computer, crew) {
		crew.incrementNumShutDownRequests();
		
		if(crew.getNumShutDownRequests() == 1) {
			System.out.println("Can't do that " + crew);
		}
		else if (crew.getNumShutDownRequests()== 2) {
			System.out.println("Can't do that " + crew + " and do not ask me again.");
		}
		else if (crew.getNumShutDownRequests() == 3) {
			System.out.println(crew.kill());
		}
		
		
		
	}
	
	

}
