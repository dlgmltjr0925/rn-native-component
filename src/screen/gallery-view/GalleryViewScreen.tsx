import React, { useCallback } from 'react';
import { StyleSheet, View } from 'react-native';

import { GalleryView } from '../../component/native/rnc-gallery-view';
import { SelectMediaEvent } from '../../component/native/rnc-gallery-view/RNCGalleryView';

export function GalleryViewScreen() {
  const handleSelectMedia = useCallback((e: SelectMediaEvent) => {
    console.log(Object.keys(e.nativeEvent.media));
  }, []);

  return (
    <View style={styles.container}>
      <GalleryView
        style={styles.galleryView}
        column={4}
        mediaType="ALL"
        onSelectMedia={handleSelectMedia}
      />
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
