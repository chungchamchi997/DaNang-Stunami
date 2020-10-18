/**
* Name: mymodel
* Based on the internal empty template. 
* Author: chung-pc
* Tags: 
*/


model mymodel

/* Insert your model definition here */

global{
	file shape_file_buildings <- file("../includes/buildings.shp");
    file shape_file_roads <- file("../includes/roads.shp");
    file file_shelter <- file("../includes/shelters.csv");
    geometry shape <- envelope(shape_file_roads); 
    int nb_locals_people <- 100 ;
    int nb_tourists_people <-1000;
  
	init{
		create building from: shape_file_buildings;
        create road from: shape_file_roads ;
        create locals_people number: nb_locals_people{
        	location<- any_location_in (one_of(road));
        }
        create tourists_people number: nb_tourists_people{
        	location<- any_location_in(one_of(road));
        }
        create shelters from: file_shelter;
          
	}
}
species building {
	string type; 
	rgb color <- #gray  ;
	
	aspect base {
		draw shape color: color ;
	}
}

species road  {
	rgb color <- #black ;
	aspect base {
		draw shape color: color ;
	}
}
species locals_people{
	rgb color <- #purple;
	aspect base{
		draw circle(30) color: color border: #black;
	}

}
species tourists_people{
	rgb color <- #yellow;
	aspect base{
		draw circle(30) color: color border: #black;
	}

}
species shelters{
	rgb color <- #green;
	aspect base{
		draw square(100) color: color border: #black;
	}

}

experiment songthan type:gui{
	
	parameter " number of locals people" var: nb_locals_people category: "locals" ;
	parameter " number of tourists people" var: nb_tourists_people category: "tourists" ;
	output {
		display danang type:opengl{
			species building aspect: base;
			species road aspect: base;
			species locals_people aspect: base;
			species tourists_people aspect: base;
			species shelters aspect: base;
			
		}
	}
}