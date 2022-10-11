import * as React from 'react';

import { StyleSheet, Text, View } from 'react-native';
import { check } from 'react-native-safety-check';

export default function App() {
  const [safe, setSafe] = React.useState<boolean>(false);
  const [virtual, setVirtual] = React.useState<boolean>(false);

  React.useEffect(() => {
    check((isSafe, isVirtualDevice) => {
      setSafe(isSafe);
      setVirtual(isVirtualDevice);
    });
  }, [safe]);

  return (
    <View style={styles.container}>
      <Text>IsSafe: {safe ? 'true' : 'false'}</Text>
      <Text>IsVirtualDevice: {virtual}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
