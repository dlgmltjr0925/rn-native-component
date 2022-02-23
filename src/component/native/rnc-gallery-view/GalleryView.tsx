import { RNCGalleryView, RNCGalleryViewProps } from './RNCGalleryView';

import React from 'react';

export interface GalleryViewProps extends RNCGalleryViewProps {}

export function GalleryView(props: GalleryViewProps) {
  return <RNCGalleryView {...props} />;
}

GalleryView.defaultProps = {
  column: 3,
};
