import React, { useEffect } from 'react';
import { StyleSheet, View,requireNativeComponent } from 'react-native';
import { request, PERMISSIONS } from 'react-native-permissions';

function App(): JSX.Element {
  const LivenessView: any = requireNativeComponent("LivenessView")


  useEffect(() => {
    (async () => {
      request(PERMISSIONS.IOS.CAMERA).then((result) => {
        console.log('result', result);
      });
    })();
  }, []);

  return (
    <View style={styles.container}>
      <LivenessView style={styles.wrapper} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1, alignItems: "stretch"
  },
  wrapper: {
    flex: 1, alignItems: "center", justifyContent: "center"
  }
});

export default App; 