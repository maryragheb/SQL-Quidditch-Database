# SQL-Quidditch-Database
# The Continued History of Quidditch at Hogwarts
Creators: Mary Ragheb, Katherine Nikolov, Luke Ackerman

## Section 1: Steps to Run the Application
1. Open a terminal
2. Navigate to the submission folder (*cd* command)
3. From within the submission folder, navigate to the executable jar file with the file path: 
	Project\out\artifacts\Project_jar
4. Execute the jar file to run the application with the command:
	java -jar Project.jar [username] [password]
    Where [username] and [password] are the username and password of your mySQL server.
     	(ex: java -jar Project.jar root p@ssword!)

*Admin Password = "goldenSnitch"

## Section 2: Technical specifications
The database for this project was created in MySQL. The backend code that is used to connect to the database is written in Java and the “front end” GUI is written using Java Swing. Creately was used to create the ERD diagram for planning and reference purposes.

## Section 3: Conceptual Design as UML
![image](https://user-images.githubusercontent.com/71101740/226648123-6f797185-0db6-4d73-bae4-af9bb82f9826.png)

## Section 4: Logical Design
![image](https://user-images.githubusercontent.com/71101740/226648254-eaf5bcb7-dabc-49d5-a3c8-532a22e99dc0.png)

## Section 5: User flow
When the database application is launched, the user can choose to log in or not. If they choose not to log in or input incorrect passwords, they are able to only view all of the database information. This includes matches, players, team information (including Head of House), the injury report, referees and commentators for a specific match, and seasons. If the user inputs the administrator password, they can still view all of the database information. With the correct password, they can now also add, delete, or modify information in the database. This includes adding a broom, season, match or injury report, deleting a broom or injury report and modifying a captain of a team or head of house. You can also assign a referee or commentator to an already existing match. Seasons can be ordered by year and filtered by the winning team. 

## Section 6: Lessons learned
As a group, we gained a lot of valuable experience building a database all the way up from a conceptual idea to a real working model that supports CRUD operations. This took everything that we have learned this semester and synthesized all the different concepts into one project which felt like a very realistic application of database design. As for specific tech experience gained, we learned a lot more about different options available in Java Swing, which was used to make the GUI. We had all previously used Swing before in OOD, but Mary in particular, who did most of the work with the GUI for this project really expanded her breadth of knowledge with Swing. We planned our project very early which was ideal because we knew exactly what needed to be done, but we could have actually started implementing these tasks slightly sooner for more efficient time management. We also met frequently over Zoom and in-person, which helped to keep us on track and focused on the end goal. In creating the database, our overall knowledge of Quidditch greatly increased. We had to research various statistics and game information to create a thorough database.

In the early stages of our project, we spent a lot of time considering how the user interface would look. We settled on a UI akin to online databases that you can find for other sports, but went through several designs before coming to this choice. One idea that had a lot of consideration was making the front page contain a list of all Quidditch matches with filtering options. This was eventually ruled out for the current design, which displays teams and other tabs that can be viewed.

There is some code that was written to perform more complicated filters on players, such as ordering names alphabetically, by position, by broom or grad year. We had problems effectively calling the SQL stored procedure from the Java code, and thus this feature was not implemented in our final application. 

## Section 7: Future work
This database realistically won’t be used much in the future. We decided to pick Quiddich as our theme because it was fun and there is a wealth of information online about Quidditch, but it is not something that has a ton of practical use for any of us. If somebody wanted to expand on this database and make a more comprehensive Harry Potter reference tool, they could add in tables that represent other groups of people like professors and students who don’t play Quidditch. The functionality to filter by player or other more complicated filters could be added. There are other fictional or non-fictional quidditch leagues, so the database could be expanded with the inclusion of those. Functionality would have to be added to differentiate between the league. The GUI could also be enhanced to support the querying and modification of this new data.
