/**
* Name: mymodel
* Based on the internal empty template. 
* Author: chung-pc
* Tags: 
*/


model tsunami

/* Insert your model definition here */

global {
	file shape_file_buildings <- file("../includes/buildings.shp");
    file shape_file_roads <- file("../includes/roads.shp");
 // file file_shelter <- file("../includes/shelters.csv");
    file shape_file_beach_roads <- file("../includes/beach_roads.shp");
    geometry shape <- envelope(shape_file_roads);
    float step <- 10 #mn; 
    int nb_locals_people <- 300;
    int nb_tourists_people <-100;
  
	init {
		//create building from: shape_file_buildings;
		
        create road from: shape_file_roads ;
        create beach_roads from: shape_file_beach_roads ;
        create bridge from: shape_file_roads with: [id::string(read("osm_id"))] {
        	if id="89366122" or id="696348478" or id="160628034" or id="199383480" or id="295386151" {
        		color<-#green;
        	}
        }
        
        
        create locals_people number: nb_locals_people {
        	location<- any_location_in(one_of(road));
        }
   
        create tourists_people number: nb_tourists_people {
        	location<- any_location_in(one_of(beach_roads));
        }
 //       create shelters from: file_shelter;
          
	}
}

species building {
	string type; 
	rgb color <- #gray  ;
	
	aspect base {
		draw shape color: color ;
	}
}

species bridge {
	string id; 
	rgb color <- #gray ;
	
	aspect base {
		draw shape color: color ;
	}
}

species road {
	rgb color <- #black ;
	aspect base {
		draw shape color: color ;
	}
}
species beach_roads {
	rgb color <- #black ;
	aspect base {
		draw shape color: color ;
	}
}
species locals_people {
	rgb color <- #purple;
	aspect base {
		draw circle(30) color: color border: #black;
	}

}
species tourists_people {
	rgb color <- #yellow;
	aspect base {
		draw circle(30) color: color border: #black;
	}

}
//species shelters {
//	rgb color <- #orange;
//	aspect base {
//		draw square(100) color: color border: #black;
//	}
//}

experiment tsunami_dn type:gui {
	
	parameter "Number of locals: " var: nb_locals_people category: "locals" ;
	parameter "Number of tourists: " var: nb_tourists_people category: "tourists" ;
	output {
		display tsunami_dn type:opengl {
			species building aspect: base;
			species road aspect: base;
			species locals_people aspect: base;
			species tourists_people aspect: base;
			//species shelters aspect: base;
			species bridge aspect: base;
			
		}
	}
}