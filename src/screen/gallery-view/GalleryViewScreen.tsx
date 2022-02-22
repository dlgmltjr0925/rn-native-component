import { StyleSheet, View } from 'react-native';

import { GalleryView } from '../../component/native/rnc-gallery-view';
import React from 'react';

export function GalleryViewScreen() {
  return (
    <View style={styles.container}>
      <GalleryView style={styles.galleryView} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  galleryView: {
    flex: 1,
  },
});
