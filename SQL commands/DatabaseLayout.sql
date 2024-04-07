CREATE TABLE ROOM
( 
	RoomId               int  IDENTITY ( 1,1 )  NOT NULL ,
	RoomNumber           int  NULL ,
	PRIMARY KEY  CLUSTERED (RoomId ASC)
)
go

CREATE TABLE SENSORTYPE
( 
	SensorTypeId         int  IDENTITY ( 1,1 )  NOT NULL ,
	Type                 varchar(50)  NULL ,
	PRIMARY KEY  CLUSTERED (SensorTypeId ASC)
)
go

CREATE TABLE SENSOR
( 
	SensorId             int  IDENTITY ( 1,1 )  NOT NULL ,
	Value                float  NULL ,
	RoomId               int  NULL ,
	SensorTypeId         int  NULL ,
	PRIMARY KEY  CLUSTERED (SensorId ASC),
	 FOREIGN KEY (RoomId) REFERENCES ROOM(RoomId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	 FOREIGN KEY (SensorTypeId) REFERENCES SENSORTYPE(SensorTypeId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go

CREATE TABLE LOG
( 
	LogId                int  IDENTITY ( 1,1 )  NOT NULL ,
	CelsiusValue         float  NULL ,
	FahrenheitValue      float  NULL ,
	SensorId             int  NULL ,
	TimeStamp            datetime  NULL ,
	PRIMARY KEY  CLUSTERED (LogId ASC),
	 FOREIGN KEY (SensorId) REFERENCES SENSOR(SensorId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go
