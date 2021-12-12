extension ListExtensions<E> on List<E> {
  E? safeGet(int index) => isEmpty || length <= index ? null : this[index];

  E? get safeGetLast => isEmpty ? null : this[length - 1];
}
