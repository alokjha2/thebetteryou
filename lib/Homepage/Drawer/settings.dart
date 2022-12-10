import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:settings_ui/settings_ui.dart';


 

class settings extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(
      title: Text("Settings",style: 
      
      GoogleFonts.ubuntu(textStyle: 
                
      
      TextStyle(fontWeight: FontWeight.w600, fontSize: 20, 
      // fontFamily: "Ubuntu"
      
      ),)
      
      
      ),
      centerTitle: true,
      elevation: 2,
      // toolbarHeight: 24,,),)
    ),
    body: SettingsList(
      sections: [
        SettingsSection(
          title: Text('Common'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: Icon(Icons.language),
              title: Text('Language'),
              value: Text('English'),
            ),
            SettingsTile.switchTile(
              onToggle: (value) {},
              initialValue: true,
              leading: Icon(Icons.format_paint),
              title: Text('Enable custom theme'),
            ),
          ],
        ),
      ],
    ),
    
    
    
    
    
    
    
    );
  }
}