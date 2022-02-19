import { GalleryViewScreen } from '../screen/gallery-view';
import { HomeScreen } from '../screen/home';
import React from 'react';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

const Stack = createNativeStackNavigator();

export function MainStackNavigation() {
  return (
    <Stack.Navigator>
      <Stack.Screen name={HomeScreen.name} component={HomeScreen} />
      <Stack.Screen
        name={GalleryViewScreen.name}
        component={GalleryViewScreen}
      />
    </Stack.Navigator>
  );
}
