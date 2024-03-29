import 'package:flutter/material.dart';
import 'package:amo/models/amomodel.dart';

class DataTile extends StatelessWidget{

	final AmoModel amomodel;
	DataTile ({this.amomodel});

	@override
	Widget build(BuildContext context){
		return Padding(
			padding: EdgeInsets.only(top: 8.0),
			child: Card(
				margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
				child: ListTile(
					leading: CircleAvatar(
						radius: 25.0,
						backgroundColor: amomodel.location.length > 0
							? Colors.lightBlue
							: Colors.red
						,
					),
					title: Text('${amomodel.firstname} ${amomodel.lastname}'),
					subtitle: Text('location: ${amomodel.location}'),
				),
			),
		);
	}
}
