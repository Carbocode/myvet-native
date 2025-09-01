import SwiftUI
#if canImport(UIKit)
import UIKit
#endif
#if canImport(AppKit)
import AppKit
#endif

// MARK: - Cross‑platform color helpers
public extension Color {
    static var platformSystemBackground: Color {
        #if os(iOS) || os(tvOS) || os(visionOS)
        Color(UIColor.systemBackground)
        #elseif os(macOS)
        Color(NSColor.windowBackgroundColor)
        #else
        Color(.sRGBLinear, red: 1, green: 1, blue: 1, opacity: 1)
        #endif
    }

    static var platformSecondarySystemBackground: Color {
        #if os(iOS) || os(tvOS) || os(visionOS)
        Color(UIColor.secondarySystemBackground)
        #elseif os(macOS)
        Color(NSColor.controlBackgroundColor)
        #else
        Color(.sRGBLinear, red: 0.96, green: 0.96, blue: 0.96, opacity: 1)
        #endif
    }

    static var platformSystemGroupedBackground: Color {
        #if os(iOS) || os(tvOS) || os(visionOS)
        Color(UIColor.systemGroupedBackground)
        #elseif os(macOS)
        Color(NSColor.windowBackgroundColor)
        #else
        Color(.sRGBLinear, red: 0.97, green: 0.97, blue: 0.97, opacity: 1)
        #endif
    }
}

// MARK: - InlineListStyle
public struct InlineListStyle: Equatable {
    public var cornerRadius: CGFloat
    public var padding: CGFloat
    public var rowSpacing: CGFloat
    public var background: Color
    public var showSeparators: Bool
    public var separatorOpacity: Double
    public var separatorInset: CGFloat
    public var shadowRadius: CGFloat
    public var shadowY: CGFloat
    public var shadowOpacity: Double

    public init(
        cornerRadius: CGFloat = 16,
        padding: CGFloat = 12,
        rowSpacing: CGFloat = 4,
        background: Color = .platformSecondarySystemBackground,
        showSeparators: Bool = true,
        separatorOpacity: Double = 0.15,
        separatorInset: CGFloat = 16,
        shadowRadius: CGFloat = 10,
        shadowY: CGFloat = 2,
        shadowOpacity: Double = 0.08
    ) {
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.rowSpacing = rowSpacing
        self.background = background
        self.showSeparators = showSeparators
        self.separatorOpacity = separatorOpacity
        self.separatorInset = separatorInset
        self.shadowRadius = shadowRadius
        self.shadowY = shadowY
        self.shadowOpacity = shadowOpacity
    }
}

// MARK: - EnvironmentKey for style
private struct InlineListStyleKey: EnvironmentKey {
    static let defaultValue = InlineListStyle()
}

public extension EnvironmentValues {
    var inlineListStyle: InlineListStyle {
        get { self[InlineListStyleKey.self] }
        set { self[InlineListStyleKey.self] = newValue }
    }
}

public extension View {
    func inlineListStyle(_ style: InlineListStyle) -> some View {
        environment(\.inlineListStyle, style)
    }
}

// MARK: - InlineListView
/// A lightweight, composable container similar to SwiftUI's `List`,
/// with custom styling and the ability to hold arbitrary content.
public struct InlineListView<Content: View>: View {
    @Environment(\.inlineListStyle) private var style
    private let content: Content
    private let header: AnyView?
    private let footer: AnyView?

    public init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder header: () -> some View = { EmptyView() },
        @ViewBuilder footer: () -> some View = { EmptyView() }
    ) {
        self.content = content()
        let _header = header()
        let _footer = footer()
        self.header = (_header is EmptyView) ? nil : AnyView(_header)
        self.footer = (_footer is EmptyView) ? nil : AnyView(_footer)
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: style.rowSpacing) {
            if let header { header }
            content
            if let footer { footer }
        }
        .padding(style.padding)
        .background(style.background)
        .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))
        .shadow(color: .black.opacity(style.shadowOpacity), radius: style.shadowRadius, y: style.shadowY)
        .accessibilityElement(children: .contain)
    }
}

// MARK: - InlineListRow
/// A row helper that provides padding and an optional separator below the row.
public struct InlineListRow<RowContent: View>: View {
    @Environment(\.inlineListStyle) private var style
    private let isLast: Bool
    private let content: RowContent

    public init(isLast: Bool = false, @ViewBuilder content: () -> RowContent) {
        self.isLast = isLast
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: 0) {
            content
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 10)
            if style.showSeparators && !isLast {
                Divider()
                    .background(Color.primary.opacity(style.separatorOpacity))
                    .padding(.leading, style.separatorInset)
            }
        }
        .contentShape(Rectangle())
    }
}

// MARK: - InlineListSection
/// Optional section grouping with a header title.
public struct InlineListSection<Content: View>: View {
    @Environment(\.inlineListStyle) private var style
    private let title: String?
    private let content: Content

    public init(_ title: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: style.rowSpacing) {
            if let title {
                Text(title.uppercased())
                    .font(.caption).bold()
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, style.padding)
            }
            InlineListView { content }
        }
    }
}

// MARK: - Convenience Builder for Arrays
/// Build rows from a collection with automatic separators.
public struct InlineListForEach<Data: RandomAccessCollection, ID: Hashable, RowContent: View>: View where Data.Element: Identifiable, Data.Element.ID == ID {
    @Environment(\.inlineListStyle) private var style
    private let data: Data
    private let row: (Data.Element) -> RowContent

    public init(_ data: Data, @ViewBuilder row: @escaping (Data.Element) -> RowContent) {
        self.data = data
        self.row = row
    }

    public var body: some View {
        InlineListView {
            ForEach(Array(zip(data.indices, data)), id: \.1.id) { index, element in
                InlineListRow(isLast: index == data.index(before: data.endIndex)) {
                    row(element)
                }
            }
        }
    }
}

// MARK: - Examples / Previews
struct InlineListView_Previews: PreviewProvider {
    struct Person: Identifiable { let id = UUID(); let name: String; let role: String }
    static let people: [Person] = [
        .init(name: "Luca Rossi", role: "iOS Engineer"),
        .init(name: "Giulia Bianchi", role: "Product Designer"),
        .init(name: "Marco Verdi", role: "QA Lead")
    ]

    static var previews: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 1) Basic arbitrary content
                InlineListView {
                    InlineListRow {
                        HStack {
                            Image(systemName: "bell.fill")
                            Text("Notifiche")
                            Spacer()
                            Toggle("", isOn: .constant(true))
                                .labelsHidden()
                        }
                    }
                    InlineListRow(isLast: true) {
                        HStack {
                            Image(systemName: "globe")
                            Text("Lingua")
                            Spacer()
                            Text("Italiano").foregroundStyle(.secondary)
                        }
                    }
                }
                .inlineListStyle(.init(cornerRadius: 14, background: Color.platformSystemBackground))
                .padding()

                // 2) Sectioned
                InlineListSection("Team") {
                    VStack(spacing: 0) {
                        ForEach(0..<people.count, id: \.self) { i in
                            InlineListRow(isLast: i == people.count - 1) {
                                HStack(spacing: 12) {
                                    Circle().frame(width: 32, height: 32)
                                    VStack(alignment: .leading) {
                                        Text(people[i].name).font(.body)
                                        Text(people[i].role).font(.caption).foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right").font(.footnote).foregroundStyle(.tertiary)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)

                // 3) Collection-based builder
                InlineListForEach(people) { person in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(person.name)
                            Text(person.role).font(.caption).foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button("Info") {}
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color.platformSystemGroupedBackground)
    }
}
