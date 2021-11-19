import React from 'react';
import { StyleSheet, Text, View, Image, Button, TextInput } from 'react-native';

export default function App() {
  return (
    <View style={{flexDirection: "column"}}>
      <Text style={{backgroundColor: "green", color: "white", fontSize: 30}}>
        Lab 1 - React Native
      </Text>
      <View style={{alignItems: "center", padding: 30}}>
          <Image
            source={require('./assets/image.png')}
          />
      </View>
      <ButtonRow/>
      <ButtonRow/>
      <View style={{alignItems: "center", padding: 30}}>
      <TextInput
          style={{width: "50%", borderWidth: 1, height: 40}}
          placeholder="E-mail"
        />
      </View>
    </View>
  );
}

const ButtonRow = () => {
  return(
    <View style={{flexDirection: "row", alignItems: "center", justifyContent: "center"}}>
    <View style={{paddingRight: 25, paddingTop: 20}}>
      <Button
        title="Button"
        color="grey"
      />
    </View>
    <View style={{paddingLeft: 25, paddingTop: 20}}>
      <Button
        title="Button"
        color="grey"
      />
    </View>
  </View>
  );
};