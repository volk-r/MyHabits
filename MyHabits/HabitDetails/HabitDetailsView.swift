//
//  HabitDetailsView.swift
//  MyHabits
//
//  Created by Roman Romanov on 25.03.2023.
//

import UIKit

final class HabitDetailsView: UIView {
    
    private var habit = Habit(name: "",
                              date: UIDatePicker().date,
                              color: AppCoolors.orange)
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: HabitDetailsTableViewCell.identifier)
        
        return tableView
    }()
    
    init(habit: Habit) {
        super.init(frame: .zero)
        self.habit = habit
        backgroundColor = AppCoolors.backgroundHabitsViewColor
        
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension HabitDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension HabitDetailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitDetailsTableViewCell.identifier, for: indexPath) as! HabitDetailsTableViewCell
        
        let index = HabitsStore.shared.dates.count - indexPath.row - 1
        let date = HabitsStore.shared.trackDateString(forIndex: index) ?? "unknown"
        let isTrackedIn = HabitsStore.shared.habit(habit, isTrackedIn: habit.date)
        cell.setupCell(date: date, isTrackedIn: isTrackedIn)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard section == 0 else { return nil }
//
//        return ProfileHeaderView()
//    }
    
}
