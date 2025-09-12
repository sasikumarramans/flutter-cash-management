part of flutter_mentions;

class OptionList extends StatelessWidget {
  const OptionList({
    super.key,
    required this.data,
    required this.onTap,
    required this.suggestionListHeight,
    this.suggestionBuilder,
    this.suggestionListDecoration,
  });

  final Widget Function(Map<String, dynamic>)? suggestionBuilder;

  final List<Map<String, dynamic>> data;

  final Function(Map<String, dynamic>) onTap;

  final double suggestionListHeight;

  final BoxDecoration? suggestionListDecoration;

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth - 16),
              child: Container(
                decoration: suggestionListDecoration ??
                    const BoxDecoration(color: Colors.white),
                constraints: BoxConstraints(
                  maxHeight: suggestionListHeight,
                  minHeight: 0,
                ),
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        onTap(data[index]);
                      },
                      child: suggestionBuilder != null
                          ? suggestionBuilder!(data[index])
                          : Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                data[index]['display'],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                    );
                  },
                ),
              ),
            );
          })
        : Container();
  }
}
