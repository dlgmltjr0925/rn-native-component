import { Pressable, Text, View } from 'react-native';
import React, { useCallback } from 'react';
import { StackActions, useNavigation } from '@react-navigation/native';

import { GalleryViewScreen } from '../gallery-view';

export function HomeScreen() {
  const navigation = useNavigation();

  const navigate = useCallback(
    (name: string, params?: object) => {
      navigation.dispatch(StackActions.push(name, params));
    },
    [navigation]
  );

  const handlePress = useCallback(
    (name: string, params?: object) => {
      return () => navigate(name, params);
    },
    [navigate]
  );

  return (
    <View>
      <Pressable onPress={handlePress(GalleryViewScreen.name)}>
        <Text>{GalleryViewScreen.name}</Text>
      </Pressable>
    </View>
  );
}
