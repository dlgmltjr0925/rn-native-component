import { ViewProps, requireNativeComponent } from 'react-native';

import { BaseSyntheticEvent } from 'react';

export enum Orientation {
  ORIENTATION_ROTATE_0,
  ORIENTATION_ROTATE_90,
  ORIENTATION_ROTATE_180,
  ORIENTATION_ROTATE_270,
}
export interface Media {
  mediaType: 'image' | 'video';
  uri: string;
  fileName?: string;
  fileSize?: number;
  width: number;
  height: number;
  orientation: Orientation;
  playableDuration?: number;
  timestamp: number;

  /** Android only */
  mimeType?: string;
}

export interface SelectMediaEvent
  extends BaseSyntheticEvent<{ media: BaseSyntheticEvent }> {}

export interface RNCGalleryViewProps extends ViewProps {
  column?: 3 | 4 | 5 | 6;
  mediaType?: 'ALL' | 'PHOTO' | 'VIDEO';
  onSelectMedia: (e: SelectMediaEvent) => void;
}

export const RNCGalleryView =
  requireNativeComponent<RNCGalleryViewProps>('RNCGalleryView');
